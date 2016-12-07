function [hIm] = SPSR(lIm, Dh, Dl, lambda,lin_p,numb_of_full_bands,subsampling)

%% Input Arguments
%%% lIm: input 3D data-cube
%%% Dh : high spectral resolution Dictionary Matrix
%%% Dl: low spectral resolution Dictionary Matrix
%%% numb_of_full_bands: number of full spectral bands
%%% subsampling: sub-sampling factor

%% Output Arguments
%%% hIm: high spectral resolution 3D data-cube

%% normalize the low-spectral resolution dictionary
norm_Dl = sqrt(sum(Dl.^2, 1));
Dl = Dl./repmat(norm_Dl, size(Dl, 1), 1);

%% remove bands : perform sub-sampling
mIm=double(lIm(:,:,1:subsampling:size(lIm,3)));

%% Initialization %%%%

hIm = (zeros([size(mIm,1),size(mIm,2),numb_of_full_bands]));

A=Dl'*Dl;
h = waitbar(0,'Computing...');
for ii = 1:size(lIm,1),
    waitbar( ii/size(lIm,1))
    parfor jj = 1:size(lIm,2),
        
        % Extract each "hyper-pixel" of the 3D data-cube
        mPatch = mIm(ii,jj,:);
        if sum(sum(mPatch)) ~=0
            % Reshape it into a vector
            mPatch=reshape(mPatch,[],1);
            
            % Calculate the norm
            mNorm = sqrt(sum(mPatch(:).^2));
            
            % And normalize the input low-spectral resolution "hyper-pixel"
            if mNorm > 1,
                y = double(mPatch)./double(mNorm);
            else
                y = double(mPatch);
            end
            
            % Solve the sparse decomposition problem, to find the sparse
            % coefficients
            w=SolveLasso(Dl, y, size(Dl,2), 'lasso', 10, lambda);
            % b=-Dl'*y;
            % w = L1QP_FeatureSign_yang(lambda, A, b,enablegpu);
            
            % Map to the high-spectral resolution Dictionary
            hPatch = Dh*w;
            
            % Linear scaling function, to scale the norm differences
            hPatch = lin_scale(hPatch, mNorm,lin_p);
            
            % Respape the values of the high-spectral resolution "hyper-pixel"
            % into the 3D data-cube
            hPatch = reshape(hPatch, [1,1,numb_of_full_bands]);
            hIm(ii,jj,:) =  hPatch;
        else
            hIm(ii,jj,:) =  lIm(ii,jj,:);
        end
    end
    
end
close(h)
hIm=uint16(hIm);
end
