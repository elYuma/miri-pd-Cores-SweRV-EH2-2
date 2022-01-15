// mask[3:0] = { 4'b1000 - 30b mask,4'b0100 - 31b mask, 4'b0010 - 28b mask, 4'b0001 - 32b mask }
always_comb begin
  case (address[14:0])
    15'b011000000000000 : mask[3:0] = 4'b0100;
//2-threads
    15'b110000000000100 : mask[3:0] = 4'b0100;
    15'b110000000001000 : mask[3:0] = 4'b0100;
    15'b110000000001100 : mask[3:0] = 4'b0100;
    15'b110000000010000 : mask[3:0] = 4'b0100;
    15'b110000000010100 : mask[3:0] = 4'b0100;
    15'b110000000011000 : mask[3:0] = 4'b0100;
    15'b110000000011100 : mask[3:0] = 4'b0100;
    15'b110000000100000 : mask[3:0] = 4'b0100;
    15'b110000000100100 : mask[3:0] = 4'b0100;
    15'b110000000101000 : mask[3:0] = 4'b0100;
    15'b110000000101100 : mask[3:0] = 4'b0100;
    15'b110000000110000 : mask[3:0] = 4'b0100;
    15'b110000000110100 : mask[3:0] = 4'b0100;
    15'b110000000111000 : mask[3:0] = 4'b0100;
    15'b110000000111100 : mask[3:0] = 4'b0100;
    15'b110000001000000 : mask[3:0] = 4'b0100;
    15'b110000001000100 : mask[3:0] = 4'b0100;
    15'b110000001001000 : mask[3:0] = 4'b0100;
    15'b110000001001100 : mask[3:0] = 4'b0100;
    15'b110000001010000 : mask[3:0] = 4'b0100;
    15'b110000001010100 : mask[3:0] = 4'b0100;
    15'b110000001011000 : mask[3:0] = 4'b0100;
    15'b110000001011100 : mask[3:0] = 4'b0100;
    15'b110000001100000 : mask[3:0] = 4'b0100;
    15'b110000001100100 : mask[3:0] = 4'b0100;
    15'b110000001101000 : mask[3:0] = 4'b0100;
    15'b110000001101100 : mask[3:0] = 4'b0100;
    15'b110000001110000 : mask[3:0] = 4'b0100;
    15'b110000001110100 : mask[3:0] = 4'b0100;
    15'b110000001111000 : mask[3:0] = 4'b0100;
    15'b110000001111100 : mask[3:0] = 4'b0100;
    15'b110000010000000 : mask[3:0] = 4'b0100;
    15'b110000010000100 : mask[3:0] = 4'b0100;
    15'b110000010001000 : mask[3:0] = 4'b0100;
    15'b110000010001100 : mask[3:0] = 4'b0100;
    15'b110000010010000 : mask[3:0] = 4'b0100;
    15'b110000010010100 : mask[3:0] = 4'b0100;
    15'b110000010011000 : mask[3:0] = 4'b0100;
    15'b110000010011100 : mask[3:0] = 4'b0100;
    15'b110000010100000 : mask[3:0] = 4'b0100;
    15'b110000010100100 : mask[3:0] = 4'b0100;
    15'b110000010101000 : mask[3:0] = 4'b0100;
    15'b110000010101100 : mask[3:0] = 4'b0100;
    15'b110000010110000 : mask[3:0] = 4'b0100;
    15'b110000010110100 : mask[3:0] = 4'b0100;
    15'b110000010111000 : mask[3:0] = 4'b0100;
    15'b110000010111100 : mask[3:0] = 4'b0100;
    15'b110000011000000 : mask[3:0] = 4'b0100;
    15'b110000011000100 : mask[3:0] = 4'b0100;
    15'b110000011001000 : mask[3:0] = 4'b0100;
    15'b110000011001100 : mask[3:0] = 4'b0100;
    15'b110000011010000 : mask[3:0] = 4'b0100;
    15'b110000011010100 : mask[3:0] = 4'b0100;
    15'b110000011011000 : mask[3:0] = 4'b0100;
    15'b110000011011100 : mask[3:0] = 4'b0100;
    15'b110000011100000 : mask[3:0] = 4'b0100;
    15'b110000011100100 : mask[3:0] = 4'b0100;
    15'b110000011101000 : mask[3:0] = 4'b0100;
    15'b110000011101100 : mask[3:0] = 4'b0100;
    15'b110000011110000 : mask[3:0] = 4'b0100;
    15'b110000011110100 : mask[3:0] = 4'b0100;
    15'b110000011111000 : mask[3:0] = 4'b0100;
    15'b110000011111100 : mask[3:0] = 4'b0100;
    15'b110000100000000 : mask[3:0] = 4'b0100;
    15'b110000100000100 : mask[3:0] = 4'b0100;
    15'b110000100001000 : mask[3:0] = 4'b0100;
    15'b110000100001100 : mask[3:0] = 4'b0100;
    15'b110000100010000 : mask[3:0] = 4'b0100;
    15'b110000100010100 : mask[3:0] = 4'b0100;
    15'b110000100011000 : mask[3:0] = 4'b0100;
    15'b110000100011100 : mask[3:0] = 4'b0100;
    15'b110000100100000 : mask[3:0] = 4'b0100;
    15'b110000100100100 : mask[3:0] = 4'b0100;
    15'b110000100101000 : mask[3:0] = 4'b0100;
    15'b110000100101100 : mask[3:0] = 4'b0100;
    15'b110000100110000 : mask[3:0] = 4'b0100;
    15'b110000100110100 : mask[3:0] = 4'b0100;
    15'b110000100111000 : mask[3:0] = 4'b0100;
    15'b110000100111100 : mask[3:0] = 4'b0100;
    15'b110000101000000 : mask[3:0] = 4'b0100;
    15'b110000101000100 : mask[3:0] = 4'b0100;
    15'b110000101001000 : mask[3:0] = 4'b0100;
    15'b110000101001100 : mask[3:0] = 4'b0100;
    15'b110000101010000 : mask[3:0] = 4'b0100;
    15'b110000101010100 : mask[3:0] = 4'b0100;
    15'b110000101011000 : mask[3:0] = 4'b0100;
    15'b110000101011100 : mask[3:0] = 4'b0100;
    15'b110000101100000 : mask[3:0] = 4'b0100;
    15'b110000101100100 : mask[3:0] = 4'b0100;
    15'b110000101101000 : mask[3:0] = 4'b0100;
    15'b110000101101100 : mask[3:0] = 4'b0100;
    15'b110000101110000 : mask[3:0] = 4'b0100;
    15'b110000101110100 : mask[3:0] = 4'b0100;
    15'b110000101111000 : mask[3:0] = 4'b0100;
    15'b110000101111100 : mask[3:0] = 4'b0100;
    15'b110000110000000 : mask[3:0] = 4'b0100;
    15'b110000110000100 : mask[3:0] = 4'b0100;
    15'b110000110001000 : mask[3:0] = 4'b0100;
    15'b110000110001100 : mask[3:0] = 4'b0100;
    15'b110000110010000 : mask[3:0] = 4'b0100;
    15'b110000110010100 : mask[3:0] = 4'b0100;
    15'b110000110011000 : mask[3:0] = 4'b0100;
    15'b110000110011100 : mask[3:0] = 4'b0100;
    15'b110000110100000 : mask[3:0] = 4'b0100;
    15'b110000110100100 : mask[3:0] = 4'b0100;
    15'b110000110101000 : mask[3:0] = 4'b0100;
    15'b110000110101100 : mask[3:0] = 4'b0100;
    15'b110000110110000 : mask[3:0] = 4'b0100;
    15'b110000110110100 : mask[3:0] = 4'b0100;
    15'b110000110111000 : mask[3:0] = 4'b0100;
    15'b110000110111100 : mask[3:0] = 4'b0100;
    15'b110000111000000 : mask[3:0] = 4'b0100;
    15'b110000111000100 : mask[3:0] = 4'b0100;
    15'b110000111001000 : mask[3:0] = 4'b0100;
    15'b110000111001100 : mask[3:0] = 4'b0100;
    15'b110000111010000 : mask[3:0] = 4'b0100;
    15'b110000111010100 : mask[3:0] = 4'b0100;
    15'b110000111011000 : mask[3:0] = 4'b0100;
    15'b110000111011100 : mask[3:0] = 4'b0100;
    15'b110000111100000 : mask[3:0] = 4'b0100;
    15'b110000111100100 : mask[3:0] = 4'b0100;
    15'b110000111101000 : mask[3:0] = 4'b0100;
    15'b110000111101100 : mask[3:0] = 4'b0100;
    15'b110000111110000 : mask[3:0] = 4'b0100;
    15'b110000111110100 : mask[3:0] = 4'b0100;
    15'b110000111111000 : mask[3:0] = 4'b0100;
    15'b110000111111100 : mask[3:0] = 4'b0100;
    15'b100000000000100 : mask[3:0] = 4'b1000;
    15'b100000000001000 : mask[3:0] = 4'b1000;
    15'b100000000001100 : mask[3:0] = 4'b1000;
    15'b100000000010000 : mask[3:0] = 4'b1000;
    15'b100000000010100 : mask[3:0] = 4'b1000;
    15'b100000000011000 : mask[3:0] = 4'b1000;
    15'b100000000011100 : mask[3:0] = 4'b1000;
    15'b100000000100000 : mask[3:0] = 4'b1000;
    15'b100000000100100 : mask[3:0] = 4'b1000;
    15'b100000000101000 : mask[3:0] = 4'b1000;
    15'b100000000101100 : mask[3:0] = 4'b1000;
    15'b100000000110000 : mask[3:0] = 4'b1000;
    15'b100000000110100 : mask[3:0] = 4'b1000;
    15'b100000000111000 : mask[3:0] = 4'b1000;
    15'b100000000111100 : mask[3:0] = 4'b1000;
    15'b100000001000000 : mask[3:0] = 4'b1000;
    15'b100000001000100 : mask[3:0] = 4'b1000;
    15'b100000001001000 : mask[3:0] = 4'b1000;
    15'b100000001001100 : mask[3:0] = 4'b1000;
    15'b100000001010000 : mask[3:0] = 4'b1000;
    15'b100000001010100 : mask[3:0] = 4'b1000;
    15'b100000001011000 : mask[3:0] = 4'b1000;
    15'b100000001011100 : mask[3:0] = 4'b1000;
    15'b100000001100000 : mask[3:0] = 4'b1000;
    15'b100000001100100 : mask[3:0] = 4'b1000;
    15'b100000001101000 : mask[3:0] = 4'b1000;
    15'b100000001101100 : mask[3:0] = 4'b1000;
    15'b100000001110000 : mask[3:0] = 4'b1000;
    15'b100000001110100 : mask[3:0] = 4'b1000;
    15'b100000001111000 : mask[3:0] = 4'b1000;
    15'b100000001111100 : mask[3:0] = 4'b1000;
    15'b100000010000000 : mask[3:0] = 4'b1000;
    15'b100000010000100 : mask[3:0] = 4'b1000;
    15'b100000010001000 : mask[3:0] = 4'b1000;
    15'b100000010001100 : mask[3:0] = 4'b1000;
    15'b100000010010000 : mask[3:0] = 4'b1000;
    15'b100000010010100 : mask[3:0] = 4'b1000;
    15'b100000010011000 : mask[3:0] = 4'b1000;
    15'b100000010011100 : mask[3:0] = 4'b1000;
    15'b100000010100000 : mask[3:0] = 4'b1000;
    15'b100000010100100 : mask[3:0] = 4'b1000;
    15'b100000010101000 : mask[3:0] = 4'b1000;
    15'b100000010101100 : mask[3:0] = 4'b1000;
    15'b100000010110000 : mask[3:0] = 4'b1000;
    15'b100000010110100 : mask[3:0] = 4'b1000;
    15'b100000010111000 : mask[3:0] = 4'b1000;
    15'b100000010111100 : mask[3:0] = 4'b1000;
    15'b100000011000000 : mask[3:0] = 4'b1000;
    15'b100000011000100 : mask[3:0] = 4'b1000;
    15'b100000011001000 : mask[3:0] = 4'b1000;
    15'b100000011001100 : mask[3:0] = 4'b1000;
    15'b100000011010000 : mask[3:0] = 4'b1000;
    15'b100000011010100 : mask[3:0] = 4'b1000;
    15'b100000011011000 : mask[3:0] = 4'b1000;
    15'b100000011011100 : mask[3:0] = 4'b1000;
    15'b100000011100000 : mask[3:0] = 4'b1000;
    15'b100000011100100 : mask[3:0] = 4'b1000;
    15'b100000011101000 : mask[3:0] = 4'b1000;
    15'b100000011101100 : mask[3:0] = 4'b1000;
    15'b100000011110000 : mask[3:0] = 4'b1000;
    15'b100000011110100 : mask[3:0] = 4'b1000;
    15'b100000011111000 : mask[3:0] = 4'b1000;
    15'b100000011111100 : mask[3:0] = 4'b1000;
    15'b100000100000000 : mask[3:0] = 4'b1000;
    15'b100000100000100 : mask[3:0] = 4'b1000;
    15'b100000100001000 : mask[3:0] = 4'b1000;
    15'b100000100001100 : mask[3:0] = 4'b1000;
    15'b100000100010000 : mask[3:0] = 4'b1000;
    15'b100000100010100 : mask[3:0] = 4'b1000;
    15'b100000100011000 : mask[3:0] = 4'b1000;
    15'b100000100011100 : mask[3:0] = 4'b1000;
    15'b100000100100000 : mask[3:0] = 4'b1000;
    15'b100000100100100 : mask[3:0] = 4'b1000;
    15'b100000100101000 : mask[3:0] = 4'b1000;
    15'b100000100101100 : mask[3:0] = 4'b1000;
    15'b100000100110000 : mask[3:0] = 4'b1000;
    15'b100000100110100 : mask[3:0] = 4'b1000;
    15'b100000100111000 : mask[3:0] = 4'b1000;
    15'b100000100111100 : mask[3:0] = 4'b1000;
    15'b100000101000000 : mask[3:0] = 4'b1000;
    15'b100000101000100 : mask[3:0] = 4'b1000;
    15'b100000101001000 : mask[3:0] = 4'b1000;
    15'b100000101001100 : mask[3:0] = 4'b1000;
    15'b100000101010000 : mask[3:0] = 4'b1000;
    15'b100000101010100 : mask[3:0] = 4'b1000;
    15'b100000101011000 : mask[3:0] = 4'b1000;
    15'b100000101011100 : mask[3:0] = 4'b1000;
    15'b100000101100000 : mask[3:0] = 4'b1000;
    15'b100000101100100 : mask[3:0] = 4'b1000;
    15'b100000101101000 : mask[3:0] = 4'b1000;
    15'b100000101101100 : mask[3:0] = 4'b1000;
    15'b100000101110000 : mask[3:0] = 4'b1000;
    15'b100000101110100 : mask[3:0] = 4'b1000;
    15'b100000101111000 : mask[3:0] = 4'b1000;
    15'b100000101111100 : mask[3:0] = 4'b1000;
    15'b100000110000000 : mask[3:0] = 4'b1000;
    15'b100000110000100 : mask[3:0] = 4'b1000;
    15'b100000110001000 : mask[3:0] = 4'b1000;
    15'b100000110001100 : mask[3:0] = 4'b1000;
    15'b100000110010000 : mask[3:0] = 4'b1000;
    15'b100000110010100 : mask[3:0] = 4'b1000;
    15'b100000110011000 : mask[3:0] = 4'b1000;
    15'b100000110011100 : mask[3:0] = 4'b1000;
    15'b100000110100000 : mask[3:0] = 4'b1000;
    15'b100000110100100 : mask[3:0] = 4'b1000;
    15'b100000110101000 : mask[3:0] = 4'b1000;
    15'b100000110101100 : mask[3:0] = 4'b1000;
    15'b100000110110000 : mask[3:0] = 4'b1000;
    15'b100000110110100 : mask[3:0] = 4'b1000;
    15'b100000110111000 : mask[3:0] = 4'b1000;
    15'b100000110111100 : mask[3:0] = 4'b1000;
    15'b100000111000000 : mask[3:0] = 4'b1000;
    15'b100000111000100 : mask[3:0] = 4'b1000;
    15'b100000111001000 : mask[3:0] = 4'b1000;
    15'b100000111001100 : mask[3:0] = 4'b1000;
    15'b100000111010000 : mask[3:0] = 4'b1000;
    15'b100000111010100 : mask[3:0] = 4'b1000;
    15'b100000111011000 : mask[3:0] = 4'b1000;
    15'b100000111011100 : mask[3:0] = 4'b1000;
    15'b100000111100000 : mask[3:0] = 4'b1000;
    15'b100000111100100 : mask[3:0] = 4'b1000;
    15'b100000111101000 : mask[3:0] = 4'b1000;
    15'b100000111101100 : mask[3:0] = 4'b1000;
    15'b100000111110000 : mask[3:0] = 4'b1000;
    15'b100000111110100 : mask[3:0] = 4'b1000;
    15'b100000111111000 : mask[3:0] = 4'b1000;
    15'b100000111111100 : mask[3:0] = 4'b1000;
    15'b010000000000100 : mask[3:0] = 4'b0100;
    15'b010000000001000 : mask[3:0] = 4'b0100;
    15'b010000000001100 : mask[3:0] = 4'b0100;
    15'b010000000010000 : mask[3:0] = 4'b0100;
    15'b010000000010100 : mask[3:0] = 4'b0100;
    15'b010000000011000 : mask[3:0] = 4'b0100;
    15'b010000000011100 : mask[3:0] = 4'b0100;
    15'b010000000100000 : mask[3:0] = 4'b0100;
    15'b010000000100100 : mask[3:0] = 4'b0100;
    15'b010000000101000 : mask[3:0] = 4'b0100;
    15'b010000000101100 : mask[3:0] = 4'b0100;
    15'b010000000110000 : mask[3:0] = 4'b0100;
    15'b010000000110100 : mask[3:0] = 4'b0100;
    15'b010000000111000 : mask[3:0] = 4'b0100;
    15'b010000000111100 : mask[3:0] = 4'b0100;
    15'b010000001000000 : mask[3:0] = 4'b0100;
    15'b010000001000100 : mask[3:0] = 4'b0100;
    15'b010000001001000 : mask[3:0] = 4'b0100;
    15'b010000001001100 : mask[3:0] = 4'b0100;
    15'b010000001010000 : mask[3:0] = 4'b0100;
    15'b010000001010100 : mask[3:0] = 4'b0100;
    15'b010000001011000 : mask[3:0] = 4'b0100;
    15'b010000001011100 : mask[3:0] = 4'b0100;
    15'b010000001100000 : mask[3:0] = 4'b0100;
    15'b010000001100100 : mask[3:0] = 4'b0100;
    15'b010000001101000 : mask[3:0] = 4'b0100;
    15'b010000001101100 : mask[3:0] = 4'b0100;
    15'b010000001110000 : mask[3:0] = 4'b0100;
    15'b010000001110100 : mask[3:0] = 4'b0100;
    15'b010000001111000 : mask[3:0] = 4'b0100;
    15'b010000001111100 : mask[3:0] = 4'b0100;
    15'b010000010000000 : mask[3:0] = 4'b0100;
    15'b010000010000100 : mask[3:0] = 4'b0100;
    15'b010000010001000 : mask[3:0] = 4'b0100;
    15'b010000010001100 : mask[3:0] = 4'b0100;
    15'b010000010010000 : mask[3:0] = 4'b0100;
    15'b010000010010100 : mask[3:0] = 4'b0100;
    15'b010000010011000 : mask[3:0] = 4'b0100;
    15'b010000010011100 : mask[3:0] = 4'b0100;
    15'b010000010100000 : mask[3:0] = 4'b0100;
    15'b010000010100100 : mask[3:0] = 4'b0100;
    15'b010000010101000 : mask[3:0] = 4'b0100;
    15'b010000010101100 : mask[3:0] = 4'b0100;
    15'b010000010110000 : mask[3:0] = 4'b0100;
    15'b010000010110100 : mask[3:0] = 4'b0100;
    15'b010000010111000 : mask[3:0] = 4'b0100;
    15'b010000010111100 : mask[3:0] = 4'b0100;
    15'b010000011000000 : mask[3:0] = 4'b0100;
    15'b010000011000100 : mask[3:0] = 4'b0100;
    15'b010000011001000 : mask[3:0] = 4'b0100;
    15'b010000011001100 : mask[3:0] = 4'b0100;
    15'b010000011010000 : mask[3:0] = 4'b0100;
    15'b010000011010100 : mask[3:0] = 4'b0100;
    15'b010000011011000 : mask[3:0] = 4'b0100;
    15'b010000011011100 : mask[3:0] = 4'b0100;
    15'b010000011100000 : mask[3:0] = 4'b0100;
    15'b010000011100100 : mask[3:0] = 4'b0100;
    15'b010000011101000 : mask[3:0] = 4'b0100;
    15'b010000011101100 : mask[3:0] = 4'b0100;
    15'b010000011110000 : mask[3:0] = 4'b0100;
    15'b010000011110100 : mask[3:0] = 4'b0100;
    15'b010000011111000 : mask[3:0] = 4'b0100;
    15'b010000011111100 : mask[3:0] = 4'b0100;
    15'b010000100000000 : mask[3:0] = 4'b0100;
    15'b010000100000100 : mask[3:0] = 4'b0100;
    15'b010000100001000 : mask[3:0] = 4'b0100;
    15'b010000100001100 : mask[3:0] = 4'b0100;
    15'b010000100010000 : mask[3:0] = 4'b0100;
    15'b010000100010100 : mask[3:0] = 4'b0100;
    15'b010000100011000 : mask[3:0] = 4'b0100;
    15'b010000100011100 : mask[3:0] = 4'b0100;
    15'b010000100100000 : mask[3:0] = 4'b0100;
    15'b010000100100100 : mask[3:0] = 4'b0100;
    15'b010000100101000 : mask[3:0] = 4'b0100;
    15'b010000100101100 : mask[3:0] = 4'b0100;
    15'b010000100110000 : mask[3:0] = 4'b0100;
    15'b010000100110100 : mask[3:0] = 4'b0100;
    15'b010000100111000 : mask[3:0] = 4'b0100;
    15'b010000100111100 : mask[3:0] = 4'b0100;
    15'b010000101000000 : mask[3:0] = 4'b0100;
    15'b010000101000100 : mask[3:0] = 4'b0100;
    15'b010000101001000 : mask[3:0] = 4'b0100;
    15'b010000101001100 : mask[3:0] = 4'b0100;
    15'b010000101010000 : mask[3:0] = 4'b0100;
    15'b010000101010100 : mask[3:0] = 4'b0100;
    15'b010000101011000 : mask[3:0] = 4'b0100;
    15'b010000101011100 : mask[3:0] = 4'b0100;
    15'b010000101100000 : mask[3:0] = 4'b0100;
    15'b010000101100100 : mask[3:0] = 4'b0100;
    15'b010000101101000 : mask[3:0] = 4'b0100;
    15'b010000101101100 : mask[3:0] = 4'b0100;
    15'b010000101110000 : mask[3:0] = 4'b0100;
    15'b010000101110100 : mask[3:0] = 4'b0100;
    15'b010000101111000 : mask[3:0] = 4'b0100;
    15'b010000101111100 : mask[3:0] = 4'b0100;
    15'b010000110000000 : mask[3:0] = 4'b0100;
    15'b010000110000100 : mask[3:0] = 4'b0100;
    15'b010000110001000 : mask[3:0] = 4'b0100;
    15'b010000110001100 : mask[3:0] = 4'b0100;
    15'b010000110010000 : mask[3:0] = 4'b0100;
    15'b010000110010100 : mask[3:0] = 4'b0100;
    15'b010000110011000 : mask[3:0] = 4'b0100;
    15'b010000110011100 : mask[3:0] = 4'b0100;
    15'b010000110100000 : mask[3:0] = 4'b0100;
    15'b010000110100100 : mask[3:0] = 4'b0100;
    15'b010000110101000 : mask[3:0] = 4'b0100;
    15'b010000110101100 : mask[3:0] = 4'b0100;
    15'b010000110110000 : mask[3:0] = 4'b0100;
    15'b010000110110100 : mask[3:0] = 4'b0100;
    15'b010000110111000 : mask[3:0] = 4'b0100;
    15'b010000110111100 : mask[3:0] = 4'b0100;
    15'b010000111000000 : mask[3:0] = 4'b0100;
    15'b010000111000100 : mask[3:0] = 4'b0100;
    15'b010000111001000 : mask[3:0] = 4'b0100;
    15'b010000111001100 : mask[3:0] = 4'b0100;
    15'b010000111010000 : mask[3:0] = 4'b0100;
    15'b010000111010100 : mask[3:0] = 4'b0100;
    15'b010000111011000 : mask[3:0] = 4'b0100;
    15'b010000111011100 : mask[3:0] = 4'b0100;
    15'b010000111100000 : mask[3:0] = 4'b0100;
    15'b010000111100100 : mask[3:0] = 4'b0100;
    15'b010000111101000 : mask[3:0] = 4'b0100;
    15'b010000111101100 : mask[3:0] = 4'b0100;
    15'b010000111110000 : mask[3:0] = 4'b0100;
    15'b010000111110100 : mask[3:0] = 4'b0100;
    15'b010000111111000 : mask[3:0] = 4'b0100;
    15'b010000111111100 : mask[3:0] = 4'b0100;
    15'b000000000000100 : mask[3:0] = 4'b0010;
    15'b000000000001000 : mask[3:0] = 4'b0010;
    15'b000000000001100 : mask[3:0] = 4'b0010;
    15'b000000000010000 : mask[3:0] = 4'b0010;
    15'b000000000010100 : mask[3:0] = 4'b0010;
    15'b000000000011000 : mask[3:0] = 4'b0010;
    15'b000000000011100 : mask[3:0] = 4'b0010;
    15'b000000000100000 : mask[3:0] = 4'b0010;
    15'b000000000100100 : mask[3:0] = 4'b0010;
    15'b000000000101000 : mask[3:0] = 4'b0010;
    15'b000000000101100 : mask[3:0] = 4'b0010;
    15'b000000000110000 : mask[3:0] = 4'b0010;
    15'b000000000110100 : mask[3:0] = 4'b0010;
    15'b000000000111000 : mask[3:0] = 4'b0010;
    15'b000000000111100 : mask[3:0] = 4'b0010;
    15'b000000001000000 : mask[3:0] = 4'b0010;
    15'b000000001000100 : mask[3:0] = 4'b0010;
    15'b000000001001000 : mask[3:0] = 4'b0010;
    15'b000000001001100 : mask[3:0] = 4'b0010;
    15'b000000001010000 : mask[3:0] = 4'b0010;
    15'b000000001010100 : mask[3:0] = 4'b0010;
    15'b000000001011000 : mask[3:0] = 4'b0010;
    15'b000000001011100 : mask[3:0] = 4'b0010;
    15'b000000001100000 : mask[3:0] = 4'b0010;
    15'b000000001100100 : mask[3:0] = 4'b0010;
    15'b000000001101000 : mask[3:0] = 4'b0010;
    15'b000000001101100 : mask[3:0] = 4'b0010;
    15'b000000001110000 : mask[3:0] = 4'b0010;
    15'b000000001110100 : mask[3:0] = 4'b0010;
    15'b000000001111000 : mask[3:0] = 4'b0010;
    15'b000000001111100 : mask[3:0] = 4'b0010;
    15'b000000010000000 : mask[3:0] = 4'b0010;
    15'b000000010000100 : mask[3:0] = 4'b0010;
    15'b000000010001000 : mask[3:0] = 4'b0010;
    15'b000000010001100 : mask[3:0] = 4'b0010;
    15'b000000010010000 : mask[3:0] = 4'b0010;
    15'b000000010010100 : mask[3:0] = 4'b0010;
    15'b000000010011000 : mask[3:0] = 4'b0010;
    15'b000000010011100 : mask[3:0] = 4'b0010;
    15'b000000010100000 : mask[3:0] = 4'b0010;
    15'b000000010100100 : mask[3:0] = 4'b0010;
    15'b000000010101000 : mask[3:0] = 4'b0010;
    15'b000000010101100 : mask[3:0] = 4'b0010;
    15'b000000010110000 : mask[3:0] = 4'b0010;
    15'b000000010110100 : mask[3:0] = 4'b0010;
    15'b000000010111000 : mask[3:0] = 4'b0010;
    15'b000000010111100 : mask[3:0] = 4'b0010;
    15'b000000011000000 : mask[3:0] = 4'b0010;
    15'b000000011000100 : mask[3:0] = 4'b0010;
    15'b000000011001000 : mask[3:0] = 4'b0010;
    15'b000000011001100 : mask[3:0] = 4'b0010;
    15'b000000011010000 : mask[3:0] = 4'b0010;
    15'b000000011010100 : mask[3:0] = 4'b0010;
    15'b000000011011000 : mask[3:0] = 4'b0010;
    15'b000000011011100 : mask[3:0] = 4'b0010;
    15'b000000011100000 : mask[3:0] = 4'b0010;
    15'b000000011100100 : mask[3:0] = 4'b0010;
    15'b000000011101000 : mask[3:0] = 4'b0010;
    15'b000000011101100 : mask[3:0] = 4'b0010;
    15'b000000011110000 : mask[3:0] = 4'b0010;
    15'b000000011110100 : mask[3:0] = 4'b0010;
    15'b000000011111000 : mask[3:0] = 4'b0010;
    15'b000000011111100 : mask[3:0] = 4'b0010;
    15'b000000100000000 : mask[3:0] = 4'b0010;
    15'b000000100000100 : mask[3:0] = 4'b0010;
    15'b000000100001000 : mask[3:0] = 4'b0010;
    15'b000000100001100 : mask[3:0] = 4'b0010;
    15'b000000100010000 : mask[3:0] = 4'b0010;
    15'b000000100010100 : mask[3:0] = 4'b0010;
    15'b000000100011000 : mask[3:0] = 4'b0010;
    15'b000000100011100 : mask[3:0] = 4'b0010;
    15'b000000100100000 : mask[3:0] = 4'b0010;
    15'b000000100100100 : mask[3:0] = 4'b0010;
    15'b000000100101000 : mask[3:0] = 4'b0010;
    15'b000000100101100 : mask[3:0] = 4'b0010;
    15'b000000100110000 : mask[3:0] = 4'b0010;
    15'b000000100110100 : mask[3:0] = 4'b0010;
    15'b000000100111000 : mask[3:0] = 4'b0010;
    15'b000000100111100 : mask[3:0] = 4'b0010;
    15'b000000101000000 : mask[3:0] = 4'b0010;
    15'b000000101000100 : mask[3:0] = 4'b0010;
    15'b000000101001000 : mask[3:0] = 4'b0010;
    15'b000000101001100 : mask[3:0] = 4'b0010;
    15'b000000101010000 : mask[3:0] = 4'b0010;
    15'b000000101010100 : mask[3:0] = 4'b0010;
    15'b000000101011000 : mask[3:0] = 4'b0010;
    15'b000000101011100 : mask[3:0] = 4'b0010;
    15'b000000101100000 : mask[3:0] = 4'b0010;
    15'b000000101100100 : mask[3:0] = 4'b0010;
    15'b000000101101000 : mask[3:0] = 4'b0010;
    15'b000000101101100 : mask[3:0] = 4'b0010;
    15'b000000101110000 : mask[3:0] = 4'b0010;
    15'b000000101110100 : mask[3:0] = 4'b0010;
    15'b000000101111000 : mask[3:0] = 4'b0010;
    15'b000000101111100 : mask[3:0] = 4'b0010;
    15'b000000110000000 : mask[3:0] = 4'b0010;
    15'b000000110000100 : mask[3:0] = 4'b0010;
    15'b000000110001000 : mask[3:0] = 4'b0010;
    15'b000000110001100 : mask[3:0] = 4'b0010;
    15'b000000110010000 : mask[3:0] = 4'b0010;
    15'b000000110010100 : mask[3:0] = 4'b0010;
    15'b000000110011000 : mask[3:0] = 4'b0010;
    15'b000000110011100 : mask[3:0] = 4'b0010;
    15'b000000110100000 : mask[3:0] = 4'b0010;
    15'b000000110100100 : mask[3:0] = 4'b0010;
    15'b000000110101000 : mask[3:0] = 4'b0010;
    15'b000000110101100 : mask[3:0] = 4'b0010;
    15'b000000110110000 : mask[3:0] = 4'b0010;
    15'b000000110110100 : mask[3:0] = 4'b0010;
    15'b000000110111000 : mask[3:0] = 4'b0010;
    15'b000000110111100 : mask[3:0] = 4'b0010;
    15'b000000111000000 : mask[3:0] = 4'b0010;
    15'b000000111000100 : mask[3:0] = 4'b0010;
    15'b000000111001000 : mask[3:0] = 4'b0010;
    15'b000000111001100 : mask[3:0] = 4'b0010;
    15'b000000111010000 : mask[3:0] = 4'b0010;
    15'b000000111010100 : mask[3:0] = 4'b0010;
    15'b000000111011000 : mask[3:0] = 4'b0010;
    15'b000000111011100 : mask[3:0] = 4'b0010;
    15'b000000111100000 : mask[3:0] = 4'b0010;
    15'b000000111100100 : mask[3:0] = 4'b0010;
    15'b000000111101000 : mask[3:0] = 4'b0010;
    15'b000000111101100 : mask[3:0] = 4'b0010;
    15'b000000111110000 : mask[3:0] = 4'b0010;
    15'b000000111110100 : mask[3:0] = 4'b0010;
    15'b000000111111000 : mask[3:0] = 4'b0010;
    15'b000000111111100 : mask[3:0] = 4'b0010;
    default           : mask[3:0] = 4'b0001;
  endcase
end