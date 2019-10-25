--<----------------------->--
-- * Trouble in Terrorist Town
-- * Author: kaasis
-- * Date: 29 April 2017.
--<----------------------->--

DATABASE = {
	TYPE = "sqlite", -- database type (sqlite or mysql)
	HOST = "localhost", -- host
	USER = "root", -- username
	PASS = "", -- password
	NAME = "", -- db name
}

CONFIG = {
	FPS_LIMIT = 61, -- max fps limit (recommended 61)
	DEFAULT_KARMA = 500, -- default karma (1-1000)
	ROUNDS = 20, -- how many rounds there will be for each map
	ROUND_PREPARE_TIME = 15, -- prepare time (in seconds)
	ROUND_TIME = 5, -- round time (in minutes)
	ROUND_END_TIME = 10, -- round end time (in seconds)
}