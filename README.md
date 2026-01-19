# AIGIS Agent Skills

Reusable skills for AI agents following the [agentskills.io](https://agentskills.io) specification.

## Available Skills

### debugger

Hypothesis-driven debugging skill for diagnosing issues in codebases using instrumented logging.

**Triggers:** Bug reports, unexpected behavior, errors, or any description of issues

**Key Features:**
- Systematic 6-phase debugging workflow
- Hypothesis generation and testing
- Instrumented logging with [Agent] prefix
- Evidence-based iteration

[View skill →](./debugger/)

## Using These Skills

These skills are designed to work with AI agents that support the Agent Skills specification:

1. Clone this repository or download individual skill folders
2. Point your AI agent to the skills directory
3. Skills will automatically activate based on their trigger descriptions

## Skill Structure

Each skill follows the agentskills.io specification:

```
skill-name/
├── SKILL.md          # Required: Instructions and metadata
├── scripts/          # Optional: Executable code
├── references/       # Optional: Additional documentation
└── assets/           # Optional: Static resources
```

## Contributing

Skills should follow the [Agent Skills specification](https://agentskills.io/specification).

## License

MIT
