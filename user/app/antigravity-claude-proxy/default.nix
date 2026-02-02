{ userSettings, ... }:
{
  home.file.".claude/settings.json".text =
    if userSettings.claudeCodeModel == "claude" then
      ''
        {
          "env": {
            "ANTHROPIC_AUTH_TOKEN": "test",
            "ANTHROPIC_BASE_URL": "http://localhost:8080",
            "ANTHROPIC_MODEL": "claude-opus-4-5-thinking",
            "ANTHROPIC_DEFAULT_OPUS_MODEL": "claude-opus-4-5-thinking",
            "ANTHROPIC_DEFAULT_SONNET_MODEL": "claude-sonnet-4-5-thinking",
            "ANTHROPIC_DEFAULT_HAIKU_MODEL": "claude-sonnet-4-5",
            "CLAUDE_CODE_SUBAGENT_MODEL": "claude-sonnet-4-5-thinking",
            "ENABLE_EXPERIMENTAL_MCP_CLI": "true"
          }
        }
      ''
    else
      ''
        {
          "env": {
            "ANTHROPIC_AUTH_TOKEN": "test",
            "ANTHROPIC_BASE_URL": "http://localhost:8080",
            "ANTHROPIC_MODEL": "gemini-3-pro-high[1m]",
            "ANTHROPIC_DEFAULT_OPUS_MODEL": "gemini-3-pro-high[1m]",
            "ANTHROPIC_DEFAULT_SONNET_MODEL": "gemini-3-flash[1m]",
            "ANTHROPIC_DEFAULT_HAIKU_MODEL": "gemini-3-flash[1m]",
            "CLAUDE_CODE_SUBAGENT_MODEL": "gemini-3-flash[1m]",
            "ENABLE_EXPERIMENTAL_MCP_CLI": "true"
          }
        }
      '';
}
