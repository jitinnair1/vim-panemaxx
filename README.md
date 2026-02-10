vim-panemaxx
=============

my fork of [`vim-maximizer`](https://github.com/szw/vim-maximizer)

Please refer to the original project for details.


Usage
-----

Toggle pane maximisation with:

    :PaneMaxx

Also the plugin can define some default mappings if the user wants to.  By default it maps to `<Leader>z` if you have a `Leader` mapped else it defaults to `<F3>`.


Author and License
------------------

Maximizer was written by Szymon Wrozynski and
[Contributors](https://github.com/szw/vim-maximizer/commits/master).

This modifications made in this fork are:
- Fixed compatibilty with later versions of vim (from 7.1 to 9.1+)
- Rename command
- Add a new default keybind `<Leader>z` with fallback to the earlier default`<F3>`
- Removed the forced layout operation (using `!`)

It is licensed under the same terms as Vim itself
