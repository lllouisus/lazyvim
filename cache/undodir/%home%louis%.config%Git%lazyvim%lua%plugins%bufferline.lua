Vim�UnDo� ��WBh��H����f����:��zt����C   *       +                           d3�1    _�                             ����                                                                                                                                                                                                                                                                                                                                                             d3�;     �                   5��                                                  5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             d3�U     �                  nh5��                                                  5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             d3�V     �                   �               5��                   $                      �      5�_�                            ����                                                                                                                                                                                                                                                                                                                                       %           V        d3�m     �              %       7local status, bufferline = pcall(require, "bufferline")   if (not status) then return end       bufferline.setup({     options = {       mode = "tabs",       separator_style = 'slant',   #    always_show_bufferline = false,   $    show_buffer_close_icons = false,       show_close_icon = false,       color_icons = true     },     highlights = {       separator = {         fg = '#073642',         bg = '#002b36',       },       separator_selected = {         fg = '#073642',       },       background = {         fg = '#657b83',         bg = '#002b36'       },       buffer_selected = {         fg = '#fdf6e3',         bold = true,       },       fill = {         bg = '#073642'       }     },   })       @vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})   Bvim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})5��            %                      �             5�_�                            ����                                                                                                                                                                                                                                                                                                                                                  V        d3�n     �                   5��                                                  �                                                �                                                �                                                �                                                �                                                �                                                5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        d3�r     �                  return5��                                                5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        d3�r     �             �                  return{}5��                                                �                                                �                                                5�_�      	                     ����                                                                                                                                                                                                                                                                                                                                                  V        d3�s     �                 5��                         
                      5�_�      
           	          ����                                                                                                                                                                                                                                                                                                                                                  V        d3�x     �                 ""�             5��                      ,                  ,       �       -                  5                      5�_�   	              
          ����                                                                                                                                                                                                                                                                                                                                                  V        d3��     �               .  "https://github.com/akinsho/bufferline.nvim"5��                                               5�_�   
                        ����                                                                                                                                                                                                                                                                                                                                                  V        d3��     �               -  "https://github.comakinsho/bufferline.nvim"5��                                               5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        d3��     �               *  "https://github.akinsho/bufferline.nvim"5��                                               5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        d3��     �               )  "https://githubakinsho/bufferline.nvim"5��                                               5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        d3��     �               #  "https://akinsho/bufferline.nvim"5��                                               5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        d3��     �                  "httpsakinsho/bufferline.nvim"5��                                               5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        d3��     �      )             �             �                   �                 config = function�                 "akinsho/bufferline.nvim"5��                         #                      �                        $                      �                         '                      �                     	   *              	       �                         2                      �                         1                      �                        0                     �                        0                     �                     
   0              
       �                        :                      �                          @                       �                        @                      �                  $       @               �      5�_�                    *        ����                                                                                                                                                                                                                                                                                                                                                  V        d3��     �               *   return{     "akinsho/bufferline.nvim",     config = function ()   ;    local status, bufferline = pcall(require, "bufferline")   if (not status) then return end       bufferline.setup({     options = {       mode = "tabs",       separator_style = 'slant',   #    always_show_bufferline = false,   $    show_buffer_close_icons = false,       show_close_icon = false,       color_icons = true     },     highlights = {       separator = {         fg = '#073642',         bg = '#002b36',       },       separator_selected = {         fg = '#073642',       },       background = {         fg = '#657b83',         bg = '#002b36'       },       buffer_selected = {         fg = '#fdf6e3',         bold = true,       },       fill = {         bg = '#073642'       }     },   })       @vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})   Bvim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})         end   }5��            )      )               F      �      5�_�                    '        ����                                                                                                                                                                                                                                                                                                                            &           '           V        d3��    �   %   (   *      D    vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})   F    vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})5��    %                     6      �       �       5�_�                    '        ����                                                                                                                                                                                                                                                                                                                            &           '           V        d3��    �   %   (   *      G    -- vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})   I    -- vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})5��    %                     6      �       �       5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             d3�,     �         +        �         +    �         *    5��                          &                      �                         (                      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             d3�0    �   *               �               +   return {     "akinsho/bufferline.nvim",     event = "VeryLazy",     config = function()   ;    local status, bufferline = pcall(require, "bufferline")   #    if (not status) then return end           bufferline.setup({         options = {           mode = "tabs",   "        separator_style = 'slant',   '        always_show_bufferline = false,   (        show_buffer_close_icons = false,            show_close_icon = false,           color_icons = true         },         highlights = {           separator = {             fg = '#073642',             bg = '#002b36',   
        },           separator_selected = {             fg = '#073642',   
        },           background = {             fg = '#657b83',             bg = '#002b36'   
        },           buffer_selected = {             fg = '#fdf6e3',             bold = true,   
        },           fill = {             bg = '#073642'   	        }         },       })       D    vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})   F    vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})     end   }    5��            *       *               �      �      �    *                      �                     5��