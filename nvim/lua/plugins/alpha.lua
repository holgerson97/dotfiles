-- Alpha is the plugin used for creating the startup dashboard
return {
    'goolord/alpha-nvim',
    config = function ()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end,
}
