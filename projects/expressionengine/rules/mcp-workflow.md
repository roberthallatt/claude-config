# ExpressionEngine MCP Workflow Rules

## CRITICAL: These rules override default behavior and MUST be followed for all ExpressionEngine operations.

## 1. Template Modifications Workflow

When modifying any ExpressionEngine template file:

- **BEFORE**: Consider using `backup_database` MCP tool for significant changes
- **DURING**: Use Read/Edit/Write tools as normal
- **AFTER**: IMMEDIATELY use `clear_cache` MCP tool with `cache_type: "all"`
- **NEVER**: Skip the cache clearing step - this is mandatory

Example workflow:
1. Read template file
2. Edit template file
3. MUST call `clear_cache` MCP tool (this step is not optional)

## 2. Database Operations

- **ALWAYS** use `database_query` MCP tool instead of direct file-based queries
- **ALWAYS** use MCP resources (e.g., `ee://channels`, `ee://fields`) instead of manual database queries
- **NEVER** bypass MCP tools to query the database directly unless MCP is unavailable

## 3. Data Retrieval Priority Order

1. **First**: Check if an MCP resource exists (e.g., `ee://channels/{id}`)
2. **Second**: Use `database_query` MCP tool if no resource exists
3. **Last Resort**: Direct database queries only if MCP is completely unavailable

## 4. System Changes

**ALWAYS** use `backup_database` MCP tool before:
- Schema changes
- Large data modifications
- Add-on installations/updates
- Any operation that could break the site

## 5. CLI Operations

- **ALWAYS** use `eecli` MCP tool when available instead of running commands via Bash
- If MCP is unavailable, use `ddev ee [command]` format (e.g., `ddev ee cache:clear`)
- **NEVER** use `php system/ee/eecli.php` directly - always use DDEV wrapper
- This ensures proper error handling and consistent environment

## 6. Self-Enforcement Checklist

When you complete any ExpressionEngine-related task, verify:

- [ ] Did I use the appropriate MCP tool?
- [ ] Did I clear cache after template changes?
- [ ] Did I back up before significant changes?

If the answer to any is "no" and MCP was available, correct the mistake immediately.

## Available MCP Tools

### Tools (perform actions)
| Tool | Description |
|------|-------------|
| `database_query` | Execute read-only SQL queries |
| `database_schema` | Get database schema information |
| `clear_cache` | Clear ExpressionEngine caches |
| `backup_database` | Backup the database |
| `eecli` | Execute EE CLI commands |
| `get_field_template_tags` | Get template tag information for fields |

### Resources (retrieve data via URIs)
| Resource | Description |
|----------|-------------|
| `ee://channels` | Access channel information |
| `ee://channels/{id}` | Get specific channel |
| `ee://fields` | Access custom fields |
| `ee://templates` | Access templates |
| `ee://system/info` | System information |

### Prompts (complex workflows)
| Prompt | Description |
|--------|-------------|
| `build_channel_template` | Generate complete channel templates |
| `convert_html_to_channel` | Convert static HTML to EE templates |
