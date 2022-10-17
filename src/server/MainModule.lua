-- Made by ProjectSolve (rbxuserid://518545938)
-- Github: https://github.com/devcomi (landarin)

local players = game:GetService("Players");

local using = false;

local configuration: {
  Rank: {
    GroupId: number;
    Name: string;
  };
  DivisionName: string;
  Division: {
    {
      GroupId: number;
      Nickname: string;
    }
  };
};

local function createStat(leaderstats: Folder, name: string, value: string)
  local stat = Instance.new("StringValue");
  stat.Name = name;
  stat.Value = value;
  stat.Parent = leaderstats;
  return;
end

local function createLeaderboard(player: Player)
  local leaderstats = Instance.new("Folder");
  leaderstats.Name = "leaderstats";
  leaderstats.Parent = player;

  createStat(leaderstats, configuration.Rank.Name, player:GetRoleInGroup(configuration.Rank.GroupId));

  for index, object in ipairs(configuration.Division) do
    if (player:IsInGroup(object.GroupId)) then
      createStat(leaderstats, configuration.DivisionName, object.Nickname);
      return;
    end;
  end;

  createStat(leaderstats, configuration.DivisionName, "None");
end;

return function (Config)
  if (using == true) then
    return;
  end

  using = true;

  configuration = Config;

  if configuration.Rank.GroupId == 0 or configuration.Rank.Name:split(" ")[1] == "" then
    using = false;
    configuration = nil;
    return;
  end

  players.PlayerAdded:Connect(createLeaderboard);
end;