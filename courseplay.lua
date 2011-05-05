--
-- Courseplay v1.30
-- Specialization for Courseplay
--
-- @author  Lautschreier / Hummel / Wolverin0815 / Bastian82
-- @version:	v1.40 04.05.2011
-- @testing:    bullgore80

courseplay = {};
courseplay_path = g_modsDirectory.."/aacourseplay/"

-- working tractors saved in this
working_course_players = {};


-- starting & stopping of courseplay
source(courseplay_path.."start_stop.lua")

-- course recording & resetting
source(courseplay_path.."recording.lua")

-- drive Modes
source(courseplay_path.."mode1.lua")
source(courseplay_path.."mode2.lua")
source(courseplay_path.."mode4.lua")
source(courseplay_path.."mode6.lua")

-- course recording & resetting
source(courseplay_path.."drive.lua")

-- Mouse/Key Managment
source(courseplay_path.."input.lua")

-- Infotext
source(courseplay_path.."global.lua")

-- Distance Check
source(courseplay_path.."distance.lua")

-- Visual Waypoints
source(courseplay_path.."signs.lua")

-- Loading/Saving Courses
source(courseplay_path.."course_management.lua")

-- loading/unloading tippers
source(courseplay_path.."tippers.lua")

-- triggers
source(courseplay_path.."triggers.lua")

-- triggers
source(courseplay_path.."combines.lua")

source(courseplay_path.."debug.lua")

source(courseplay_path.."button.lua")
source(courseplay_path.."hud.lua")
source(courseplay_path.."settings.lua")
