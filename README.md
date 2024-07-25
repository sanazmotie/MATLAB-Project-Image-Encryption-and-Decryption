# MATLAB Project: Image Encryption and Decryption

This repository contains a project focused on exploring image processing and encryption techniques using MATLAB. The primary objective is to develop a program that encrypts a user-provided sentence into an image and subsequently decrypts it back to its original form. This endeavor is part of my initial attempts to understand and implement encryption and Decryption methods within the realm of image processing in MATLAB.

## Project Overview

The project is divided into two main components:
1. **Encryption**: Embedding a user-provided sentence into an image.
2. **Decryption**: Extracting the embedded sentence back from the image.

### Encryption Process

1. **Image Reading**: The selected image is read into the program.
    ```matlab
    photo = imread('photo.bmp');
    [photo_row, photo_column, z] = size(photo);
    photo_row8 = floor(photo_row / 8);
    photo_column8 = floor(photo_column / 8);
    ```
2. **Bit Manipulation and Variance Calculation**: The least significant bit of each pixel is set to zero, and the variance of pixel values in each 3x3 block is calculated to determine the block with the minimum variance.
    ```matlab
    mv = minvar(photo);
    ```
3. **Binary Conversion**: The sentence is converted to its binary representation.
    ```matlab
    p = 'Enter the sentence to encrypt:\n';
    x = input(p, 's');
    bin_matrix = dec2bin(x, 8);
    ```
4. **Random Matrix Generation**: A random matrix is generated using a user-provided seed, determining the positions for embedding bits of the sentence into the image.
    ```matlab
    p = 'Enter the seed:\n';
    seed = input(p);
    [a, b] = size(bin_matrix);
    rand_matrix = random_matris(seed, a);
    ```
5. **Embedding Process**: The binary bits of the sentence are embedded into the corresponding pixels of the image, as determined by the random matrix.
    ```matlab
    k = 0;
    l = 1;
    for i = 1:a
        for j = 1:b
            k = k + 1;
            r = mod(rand_matrix(i, j), 8);
            q = floor(rand_matrix(i, j) / 8);
            if r == 0
                r = 8;
                q = q - 1;
            end
            if bin_matrix(i, j) == '1' && mod(photo(((l-1)*8)+r, ((k-1)*8)+q+1, mv(k, l)), 2) == 0
                photo(((l-1)*8)+r, ((k-1)*8)+q+1, mv(k, l)) = photo(((l-1)*8)+r, ((k-1)*8)+q+1, mv(k, l)) + 1;
            elseif bin_matrix(i, j) == '0' && mod(photo(((l-1)*8)+r, ((k-1)*8)+q+1, mv(k, l)), 2) == 1
                photo(((l-1)*8)+r, ((k-1)*8)+q+1, mv(k, l)) = photo(((l-1)*8)+r, ((k-1)*8)+q+1, mv(k, l)) + 1;
            end
            if k == (photo_row8 - 1)
                l = l + 1;
                k = 0;
            end
        end
        if l > photo_column8
            disp('The sentence is too long to be embedded in the image.')
            break
        end
    end
    imwrite(photo, 'photo_encrypted.bmp', 'bmp')
    ```
6. **Saving the Encrypted Image**: The image with the embedded sentence is saved.

### Decryption Process

1. **Reading the Encrypted Image**: The encrypted image is read into the program.
    ```matlab
    photo = imread('photo_ramz.bmp');
    ```
2. **Seed and Character Count Input**: The user is prompted to enter the seed used during encryption and the number of characters in the sentence.
    ```matlab
    p = 'Enter the seed:\n';
    seed = input(p);
    p = 'Enter the number of characters:\n';
    a = input(p);
    ```
3. **Random Matrix Generation**: The same random matrix used during encryption is generated using the provided seed and character count.
    ```matlab
    rand_matrix = random_matris(seed, a);
    mv = minvar(photo);
    ```
4. **Bit Extraction**: For each character in the sentence, the corresponding bits are extracted from the image using the positions determined by the random matrix.
    ```matlab
    k = 0;
    l = 1;
    sentence = ' ';
    for i = 1:a
        word = '';
        for j = 1:8
            k = k + 1;
            r = mod(rand_matrix(i, j), 8);
            q = floor(rand_matrix(i, j) / 8);
            if r == 0
                r = 8;
                q = q - 1;
            end
            if mod(photo(((l-1)*8)+r, ((k-1)*8)+q+1, mv(k, l)), 2) == 0
                word = strcat(word, '0');
            else
                word = strcat(word, '1');
            end
            if k == photo_row8 - 1
                l = l + 1;
                k = 0;
            end
        end
        word = bin2dec(word);
        word = char(word);
        sentence = strcat(sentence, word);
    end
    ```
5. **Binary to Text Conversion**: The extracted bits are converted back to characters to form the original sentence.
6. **Displaying the Sentence**: The decrypted sentence is displayed to the user.
    ```matlab
    disp(sentence)
    ```

### Testing the Program

- Providing an incorrect seed during decryption will result in an incorrect sentence.
- The program ensures that the correct seed and character count are used to successfully retrieve the original sentence.


