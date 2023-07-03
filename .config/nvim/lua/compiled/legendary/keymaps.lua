local table = {
	{
		'<leader>tt',
		description = 'toggle trouble',
		mode = 'n'
	},
	{
		'<leader>lf',
		description = 'format file',
		mode = 'n'
	},
	{
		'k',
		description = 'Move up',
		mode = 'x'
	},
	{
		'j',
		description = 'Move down',
		mode = 'x'
	},
	{
		'p',
		description = 'Dont copy replaced text',
		mode = 'x'
	},
	{
		'<C-x>',
		description = 'Escape terminal mode',
		mode = 't'
	},
	{
		'<Down>',
		description = 'Move down',
		mode = 'v'
	},
	{
		'<Up>',
		description = 'Move up',
		mode = 'v'
	},
	{
		'<C-e>',
		description = 'End of line',
		mode = 'i'
	},
	{
		'<C-j>',
		description = 'Move down',
		mode = 'i'
	},
	{
		'<C-h>',
		description = 'Move left',
		mode = 'i'
	},
	{
		'<C-k>',
		description = 'Move up',
		mode = 'i'
	},
	{
		'<C-b>',
		description = 'Beginning of line',
		mode = 'i'
	},
	{
		'<C-l>',
		description = 'Move right',
		mode = 'i'
	},
	{
		'<leader>ch',
		description = 'Mapping cheatsheet',
		mode = 'n'
	},
	{
		'k',
		description = 'Move up',
		mode = 'n'
	},
	{
		'v[',
		description = 'increase vertical split',
		mode = 'n'
	},
	{
		'<leader>tn',
		description = 'new tab',
		mode = 'n'
	},
	{
		'v]',
		description = 'decrease vertical split',
		mode = 'n'
	},
	{
		'w[',
		description = 'increase horizontal split',
		mode = 'n'
	},
	{
		'<C-h>',
		description = 'Window left',
		mode = 'n'
	},
	{
		'<leader>tq',
		description = 'close tab',
		mode = 'n'
	},
	{
		'<C-s>',
		description = 'Save file',
		mode = 'n'
	},
	{
		'<C-t>',
		description = 'tab next',
		mode = 'n'
	},
	{
		'<C-j>',
		description = 'Window down',
		mode = 'n'
	},
	{
		'<Down>',
		description = 'Move down',
		mode = 'n'
	},
	{
		'<S-t>',
		description = 'tab prev',
		mode = 'n'
	},
	{
		'<C-k>',
		description = 'Window up',
		mode = 'n'
	},
	{
		'<Up>',
		description = 'Move up',
		mode = 'n'
	},
	{
		'<leader>t.',
		description = 'tab move +1',
		mode = 'n'
	},
	{
		'<Esc>',
		description = 'Clear highlights',
		mode = 'n'
	},
	{
		'<C-c>',
		description = 'Copy whole file',
		mode = 'n'
	},
	{
		'<leader>t,',
		description = 'tab move -1',
		mode = 'n'
	},
	{
		'j',
		description = 'Move down',
		mode = 'n'
	},
	{
		'w]',
		description = 'decrease horizontal split',
		mode = 'n'
	},
	{
		'<C-l>',
		description = 'Window right',
		mode = 'n'
	},
	{
		'<leader>b',
		description = 'New buffer',
		mode = 'n'
	},
	{
		'<leader>rn',
		description = 'Toggle relative number',
		mode = 'n'
	},
	{
		'<leader>n',
		description = 'Toggle line number',
		mode = 'n'
	},
	{
		'[d',
		description = 'Goto prev',
		mode = 'n'
	},
	{
		'<leader>wl',
		description = 'List workspace folders',
		mode = 'n'
	},
	{
		'<leader>lf',
		description = 'LSP formatting',
		mode = 'n'
	},
	{
		'<leader>wr',
		description = 'Remove workspace folder',
		mode = 'n'
	},
	{
		'<leader>wa',
		description = 'Add workspace folder',
		mode = 'n'
	},
	{
		']d',
		description = 'Goto next',
		mode = 'n'
	},
	{
		'<leader>ls',
		description = 'LSP signature help',
		mode = 'n'
	},
	{
		'<leader>fr',
		description = 'open projects',
		mode = 'v'
	},
	{
		'<leader>gt',
		description = 'Git status',
		mode = 'n'
	},
	{
		'<leader>fb',
		description = 'Find buffers',
		mode = 'n'
	},
	{
		'<leader>fr',
		description = 'open projects',
		mode = 'n'
	},
	{
		'<leader>pt',
		description = 'Pick hidden term',
		mode = 'n'
	},
	{
		'<leader>fh',
		description = 'Help page',
		mode = 'n'
	},
	{
		'<leader>fp',
		description = 'open projects',
		mode = 'n'
	},
	{
		'<leader>fo',
		description = 'Find oldfiles',
		mode = 'n'
	},
	{
		'<leader>ff',
		description = 'Find files',
		mode = 'n'
	},
	{
		'<leader>ma',
		description = 'telescope bookmarks',
		mode = 'n'
	},
	{
		'<leader>fz',
		description = 'Find in current buffer',
		mode = 'n'
	},
	{
		'<leader>fa',
		description = 'Find all',
		mode = 'n'
	},
	{
		'<leader>th',
		description = 'Nvchad themes',
		mode = 'n'
	},
	{
		'<leader>cm',
		description = 'Git commits',
		mode = 'n'
	},
	{
		'<leader>fw',
		description = 'Live grep',
		mode = 'n'
	},
	{
		'<leader>st',
		description = 'Toggle scrollbar',
		mode = 'n'
	},
	{
		'<leader>x',
		description = 'Close buffer',
		mode = 'n'
	},
	{
		'<tab>',
		description = 'Goto next buffer',
		mode = 'n'
	},
	{
		'<S-tab>',
		description = 'Goto prev buffer',
		mode = 'n'
	},
	{
		'<leader>di',
		description = 'Increment (dial) in visual',
		mode = 'v'
	},
	{
		'<leader>du',
		description = 'Decrement (dial) in visual',
		mode = 'v'
	},
	{
		'<leader>di',
		description = 'Increment (dial) in normal',
		mode = 'n'
	},
	{
		'<leader>du',
		description = 'Decrement (dial) in normal',
		mode = 'n'
	},
	{
		'<leader>ca',
		description = 'code action',
		mode = 'n'
	},
	{
		'<leader>pD',
		description = 'peek type definition',
		mode = 'n'
	},
	{
		'<leader>q',
		description = 'code navigation',
		mode = 'n'
	},
	{
		'<leader>hd',
		description = 'hover doc',
		mode = 'n'
	},
	{
		'<leader>ra',
		description = 'rename',
		mode = 'n'
	},
	{
		'<leader>lp',
		description = 'lsp finder',
		mode = 'n'
	},
	{
		'<leader>gd',
		description = 'goto definition',
		mode = 'n'
	},
	{
		'<leader>ld',
		description = 'line diagnostics',
		mode = 'n'
	},
	{
		'<leader>gD',
		description = 'goto type definition',
		mode = 'n'
	},
	{
		'<leader>bd',
		description = 'buffer diagnostics',
		mode = 'n'
	},
	{
		'<leader>pd',
		description = 'peek definition',
		mode = 'n'
	},
	{
		'<leader>cd',
		description = 'cursor diagnostics',
		mode = 'n'
	},
	{
		'<S-tab>',
		description = 'Goto prev buffer',
		mode = 'n'
	},
	{
		'<tab>',
		description = 'Goto next buffer',
		mode = 'n'
	},
	{
		'<leader>xx',
		description = 'Close buffer',
		mode = 'n'
	},
	{
		'<leader>/',
		description = 'Toggle comment',
		mode = 'v'
	},
	{
		'<leader>/',
		description = 'Toggle comment',
		mode = 'n'
	},
	{
		'<leader>.',
		description = 'Focus navbuddy',
		mode = 'n'
	},
	{
		'<leader>ll',
		description = 'Legendary search',
		mode = 'n'
	},
	{
		'[c',
		description = 'Jump to prev hunk',
		mode = 'n'
	},
	{
		'<leader>gb',
		description = 'Blame line',
		mode = 'n'
	},
	{
		'<leader>rh',
		description = 'Reset hunk',
		mode = 'n'
	},
	{
		']c',
		description = 'Jump to next hunk',
		mode = 'n'
	},
	{
		'<leader>td',
		description = 'Toggle deleted',
		mode = 'n'
	},
	{
		'<leader>ph',
		description = 'Preview hunk',
		mode = 'n'
	},
	{
		'<leader>;',
		description = 'Toggle nvimtree',
		mode = 'n'
	},
	{
		'<leader>cc',
		description = 'Jump to current context',
		mode = 'n'
	},
	{
		'<leader>rf',
		description = 'Decrement (dial) in normal',
		mode = 'v'
	},
	{
		'<leader>ri',
		description = 'Decrement (dial) in normal',
		mode = 'v'
	},
	{
		'<leader>re',
		description = 'Increment (dial) in normal',
		mode = 'v'
	},
	{
		'<leader>rv',
		description = 'Increment (dial) in normal',
		mode = 'v'
	},
	{
		'<leader>ri',
		description = 'Decrement (dial) in normal',
		mode = 'n'
	},
	{
		'<leader>rbf',
		description = 'Decrement (dial) in normal',
		mode = 'n'
	},
	{
		'<leader>rb',
		description = 'Increment (dial) in normal',
		mode = 'n'
	},
	{
		'<A-v>',
		description = 'Toggle vertical term',
		mode = 't'
	},
	{
		'<A-h>',
		description = 'Toggle horizontal term',
		mode = 't'
	},
	{
		'<A-i>',
		description = 'Toggle floating term',
		mode = 't'
	},
	{
		'<A-h>',
		description = 'Toggle horizontal term',
		mode = 'n'
	},
	{
		'<A-v>',
		description = 'Toggle vertical term',
		mode = 'n'
	},
	{
		'<leader>v',
		description = 'New vertical term',
		mode = 'n'
	},
	{
		'<A-i>',
		description = 'Toggle floating term',
		mode = 'n'
	},
	{
		'<leader>h',
		description = 'New horizontal term',
		mode = 'n'
	},
	{
		'<leader>wK',
		description = 'Which-key all keymaps',
		mode = 'n'
	},
	{
		'<leader>wk',
		description = 'Which-key query lookup',
		mode = 'n'
	},
	{
		'<leader>,',
		description = 'Neogen generate annotation',
		mode = 'n'
	}
}

return table