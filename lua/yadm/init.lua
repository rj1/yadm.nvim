local default_config = {
	yadm_dir = vim.fn.expand("$XDG_DATA_HOME/yadm/repo.git"),
}

local updateconfig = function(config)
	vim.validate({ config = { config, "table", true } })
	config = vim.tbl_deep_extend("force", default_config, config or {})

	vim.validate({
		yadm_dir = { config.yadm_dir, "string" },
	})

	return config
end

local function yadm_installed()
	return vim.fn.executable("yadm") == 1
end

local function is_yadm_file()
	local filepath = vim.api.nvim_buf_get_name(0)
	local yadm_files = vim.fn.systemlist("yadm list -a")
	for _, file in ipairs(yadm_files) do
		file = vim.fn.expand("$HOME/" .. file)
		if file == filepath then
			return true
		end
	end
	return false
end

local createautocmd = function(opts)
	vim.api.nvim_create_autocmd("BufEnter", {
		pattern = "*",
		group = vim.api.nvim_create_augroup("yadm", { clear = true }),
		callback = function()
			if is_yadm_file() then
				vim.fn.FugitiveDetect(opts.yadm_dir)
			end
		end,
	})
end

local setup = function(opts)
	if not yadm_installed() then
		print("[yadm.nvim] yadm executable not found on this system")
		return
	end

	opts = updateconfig(opts)
	createautocmd(opts)
end

return {
	setup = setup,
}
