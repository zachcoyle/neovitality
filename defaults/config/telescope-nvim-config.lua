require('telescope').setup{
    defaults = { 
        file_ignore_patterns = {
            "flake.lock", 
            "yarn.lock",
        },
    }
}
