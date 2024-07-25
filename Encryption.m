% Read the image
photo = imread('photo.bmp');
[photo_row, photo_column, z] = size(photo);

% Calculate the size of the image divided by 8
photo_row8 = floor(photo_row / 8);
photo_column8 = floor(photo_column / 8);

% Compute the minimum variance matrix
mv = minvar(photo);

% Prompt the user to enter a sentence and convert it to binary
p = 'Enter the sentence to encrypt:\n';
x = input(p, 's');
bin_matrix = dec2bin(x, 8);

% Prompt the user to enter a seed for random matrix generation
p = 'Enter the seed:\n';
seed = input(p);

% Get the size of the binary matrix
[a, b] = size(bin_matrix);

% Generate the random matrix based on the seed and the size of the binary matrix
rand_matrix = random_matris(seed, a);

% Initialize counters for row and column
k = 0;
l = 1;

% Loop through each character in the binary matrix
for i = 1:a
    for j = 1:b
        % Increment the column counter
        k = k + 1;
        
        % Calculate the position in the 8x8 block
        r = mod(rand_matrix(i, j), 8);
        q = floor(rand_matrix(i, j) / 8);
        
        % Adjust the position if the remainder is zero
        if r == 0
            r = 8;
            q = q - 1;
        end
        
        % Embed the binary data into the image
        if bin_matrix(i, j) == '1' && mod(photo(((l-1)*8)+r, ((k-1)*8)+q+1, mv(k, l)), 2) == 0
            photo(((l-1)*8)+r, ((k-1)*8)+q+1, mv(k, l)) = photo(((l-1)*8)+r, ((k-1)*8)+q+1, mv(k, l)) + 1;
        elseif bin_matrix(i, j) == '0' && mod(photo(((l-1)*8)+r, ((k-1)*8)+q+1, mv(k, l)), 2) == 1
            photo(((l-1)*8)+r, ((k-1)*8)+q+1, mv(k, l)) = photo(((l-1)*8)+r, ((k-1)*8)+q+1, mv(k, l)) + 1;
        end
        
        % Move to the next row if the end of the column is reached
        if k == (photo_row8 - 1)
            l = l + 1;
            k = 0;
        end
    end
    
    % Check if the sentence is too long to be embedded in the image
    if l > photo_column8
        disp('The sentence is too long to be embedded in the image.')
        break
    end
end

% Save the encrypted image
imwrite(photo, 'photo_encrypted.bmp', 'bmp')
