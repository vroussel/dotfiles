vim.filetype.add({
    extension = {
        puml = "plantuml",
        pu = "plantuml",
    },
})

vim.filetype.add({
    pattern = {
        [".*[aA]nsible.*/.*%.ya?ml"] = "yaml.ansible",
        [".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
        [".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
        [".*/roles/.*/handlers/.*%.ya?ml"] = "yaml.ansible",
    },
})

vim.filetype.add({
    extension = {
        j2 = "jinja",
        jinja = "jinja",
        jinja2 = "jinja",
    },
})
