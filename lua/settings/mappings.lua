--[[
 String value 	Help page	  Affected modes
 ''             mapmode-nvo       Normal, Visual, Select, Operator-pending
 'n'            mapmode-n 	  Normal
 'v'            mapmode-v 	  Visual and Select
 's'            mapmode-s 	  Select
 'x'            mapmode-x 	  Visual
 'o'            mapmode-o 	  Operator-pending
 '!'            mapmode-ic 	  Insert and Command-line
 'i'            mapmode-i 	  Insert
 'l'            mapmode-l 	  Insert, Command-line, Lang-Arg
 'c'            mapmode-c 	  Command-line
 't'            mapmode-t 	  Terminal
--]]

local map = {
    {'n', ';', ':', {silent = false, nowait = true}},

	-- [file option]
    {'', 'S', ':w<CR>', {noremap = false}},
    {'', 'Q', ':q<CR>', {noremap = false}},
    {'n', '<C-q>', ':q!<CR>'},
    {'c', 'w!!', 'w !sudo tee >/dev/null %'},
    
    {'n', '<', '<<'},
    {'n', '>', '>>'},
    {'v', '<', '<<'},
    {'v', '>', '>>'},
    
    {'n', 'Y', 'y$'},
    {'v', 'Y', '"+y'},
    {'', '<C-a>', 'ggVG', {noremap = false}},
    
    -- [cursor movement]
    {'', 'K', '5k'},
    {'', 'J', '5j'},
    {'', 'L', '5l'},
    {'', 'H', '5h'},
    
    -- Ctrl + K or J will move up/down the view port without moving the cursor
    {'n', '<C-k>', '5<C-y>'},
    {'n', '<C-j>', '5<C-e>'},
    
    -- Insert and Command Mode Cursor Movement.
    {'!', '<C-w>', '<Up>'},
    {'!', '<C-s>', '<Down>'},
    {'!', '<C-a>', '<Left>'},
    {'!', '<C-d>', '<Right>'},
    
    -- [window management]
    {'', 's', '<nop>'},
    {'', 'sk', ':set nosplitbelow<CR>:split<CR>:e'},
    {'', 'sj', ':set splitbelow<CR>:split<CR>:e'},
    {'', 'sh', ':set nosplitright<CR>:vsplit<CR>:e'},
    {'', 'sl', ':set splitright<CR>:vsplit<CR>:e'},
    
    {'n', 'tl', '<C-w>l'},
    {'n', 'tk', '<C-w>k'},
    {'n', 'tj', '<C-w>j'},
    {'n', 'th', '<C-w>h'},
    
    {'', '<Up>', ':res +5<CR>'},
    {'', '<Down>', ':res -5<CR>'},
    {'', '<Left>', ':vertical resize-5<CR>'},
    {'', '<Right>', ':vertical resize+5<CR>'},
    
    {'', 'c', '<nop>'},
    {'n', 'cj', '<C-w>t<C-w>K'},
    {'n', 'ck', '<C-w>t<C-w>H'},
    
    -- [table management]
    {'', 'st', ':table<CR>'},
    {'', 't-', ':-tabnext<CR>'},
    {'', 't=', ':+tabnext<CR>'},
    
    {'n', '<m-1>', '1gt'},
    {'n', '<m-2>', '2gt'},
    {'n', '<m-3>', '3gt'},
    {'n', '<m-4>', '4gt'},
    {'n', '<m-5>', '5gt'},
    {'n', '<m-6>', '6gt'},
    {'n', '<m-7>', '7gt'},
    {'n', '<m-8>', '8gt'},
    {'n', '<m-9>', '9gt'},
    
    -- [other]
    {'n', '<leader>sc', ':set spell!<CR>'},
    {'n', '<leader>pm', ':set paste!<CR>'},
    {'n', '<leader><cr>', ':nohlsearch<CR>'},
    
    -- press space twice to jump to the next ':' and edit it
    {'n', '<leader><leader>', '<ESC>/<++><CR>:nohlsearch<CR>c4l'},
    -- find the conflict line of git
    {'', '<leader>fc', '/\\v^[<\\|=>]{7}( .*\\|$)<CR>'},

}

return map

