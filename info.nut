/*
 * This file is part of MinimalGS, which is a GameScript for OpenTTD
 * Copyright (C) 2012-2013  Leif Linse
 *
 * MinimalGS is free software; you can redistribute it and/or modify it 
 * under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 2 of the License
 *
 * MinimalGS is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with MinimalGS; If not, see <http://www.gnu.org/licenses/> or
 * write to the Free Software Foundation, Inc., 51 Franklin Street, 
 * Fifth Floor, Boston, MA 02110-1301 USA.
 *
 */

require("version.nut");

class FMainClass extends GSInfo {
	function GetAuthor()		{ return "2TallTyler"; }
	function GetName()			{ return "Hometown Subsidies"; }
	function GetDescription() 	{ return "Place your HQ in a town, get subsidy offers, profit."; }
	function GetVersion()		{ return SELF_VERSION; }
	function GetDate()			{ return "2021-11-16"; }
	function CreateInstance()	{ return "MainClass"; }
	function GetShortName()		{ return "TT01"; } // Replace this with your own unique 4 letter string
	function GetAPIVersion()	{ return "1.3"; }
	function GetURL()			{ return "https://github.com/2TallTyler/hometown_subsidies"; }

	function GetSettings() {
		AddSetting({
			name = "log_level",
			description = "Debug: Log level (higher = print more)",
			easy_value = 3,
			medium_value = 3,
			hard_value = 3,
			custom_value = 3,
			flags = CONFIG_INGAME,
			min_value = 1,
			max_value = 3
		});
		AddLabels("log_level",
		{_1 = "1: Info",
		_2 = "2: Verbose",
		_3 = "3: Debug"
		});

		AddSetting({
			name = "max_subsidy_distance",
			description = "Maximum subsidy distance",
			easy_value = 70,
			medium_value = 70,
			hard_value = 70,
			custom_value = 128,
			flags = CONFIG_INGAME,
			min_value = 70,
			max_value = 4096,
			step_size = 10
		});
	}
}

RegisterGS(FMainClass());
