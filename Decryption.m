% Decryption process

% Read the encrypted image
photo = imread('photo_ramz.bmp');

% Prompt the user to enter the seed used during encryption
p = 'Enter the seed:\n';
seed = input(p);

% Prompt the user to enter the number of characters in the sentence
p = 'Enter the number of characters:\n';
a = input(p);

% Generate the same random matrix based on the seed and number of characters
rand_matrix = random_matris(seed, a);

% Compute the minimum variance matrix
mv = minvar(photo);

% Initialize counters and the sentence variable
k = 0;
l = 1;
sentence = ' ';

% Loop through each character in the sentence
for i = 1:a
    % Initialize a variable to hold the binary representation of the character
    word = '';
    
    % Loop through each bit of the character (8 bits per character)
    for j = 1:8
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
        
        % Extract the bit from the image
        if mod(photo(((l-1)*8)+r, ((k-1)*8)+q+1, mv(k, l)), 2) == 0
            word = strcat(word, '0');
        else
            word = strcat(word, '1');
        end
        
        % Move to the next row if the end of the column is reached
        if k == photo_row8 - 1
            l = l + 1;
            k = 0;
        end
    end
    
    % Convert the binary representation to a decimal value (ASCII code)
    word = bin2dec(word);
    
    % Convert the ASCII code to a character
    word = char(word);
    
    % Append the character to the sentence
    sentence = strcat(sentence, word);
end

% Display the decrypted sentence
disp(sentence)
