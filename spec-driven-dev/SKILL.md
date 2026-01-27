---
name: spec-driven-dev
description: Spec-Driven Development using spec-kit with colocated module documentation. Use when (1) planning new features with spec-kit workflow (specify → plan → tasks → implement), (2) creating or updating module SPEC.md files, (3) bootstrapping specs for existing codebases, (4) graduating completed specs to permanent documentation. Integrates with Obsidian for knowledge graph visualization.
---

# Spec-Driven Development

Structured development workflow combining spec-kit's specification-first approach with colocated module documentation and Obsidian graph visualization.

## Architecture Overview

```
project/
├── src/modules/              # Code + colocated docs
│   ├── incidents/
│   │   ├── SPEC.md          # Module truth (graduated)
│   │   └── components/
│   ├── chat/
│   │   ├── SPEC.md
│   │   └── ...
│
├── specs/                    # Active development (temporary)
│   └── 042-feature-name/
│       ├── spec.md
│       ├── plan.md
│       └── tasks.md
│
├── docs/                     # Cross-cutting only
│   ├── architecture/
│   └── decisions/
│
└── constitution.md           # Project principles
```

**Key principle:** Module `SPEC.md` = permanent truth (nouns). `specs/` = active work (verbs).

## Workflows

### 1. New Feature Development

```
1. Executive adds requirements to module's SPEC.md ## Planned section
2. Engineer runs: /speckit.specify "Implement {feature} per SPEC.md"
   → Creates specs/NNN-feature/spec.md
3. /speckit.plan → /speckit.tasks → /speckit.implement
4. After merge: Graduate (move Planned → Current State, archive spec)
```

### 2. Bootstrap Existing Codebase

For modules without SPEC.md, generate drafts from code analysis.

**Two approaches:**

1. **Shell script** (creates skeletons):
   ```bash
   scripts/bootstrap-specs.sh src/modules
   ```

2. **AI-enhanced** (recommended - creates complete specs):
   See `references/bootstrap-prompts.md` for detailed analysis guide.

**What to analyze:**
- Component files → features and UI capabilities
- Type definitions → data models and boundaries
- Hook files (`use*.ts`) → state management features
- Import statements → module dependencies
- Service calls → backend integrations

**Quality bar:** No TODOs, no placeholders, accurate wiki-links, useful for onboarding.

### 3. Graduation Flow

After feature ships:

```markdown
# In module SPEC.md:

## Current State
- [existing features]
- NEW: {graduated feature}     ← Move from Planned

## Planned
- {remove shipped feature}

## History
- YYYY-MM-DD: {feature} (spec-NNN)  ← Add entry
```

Then delete or archive `specs/NNN-feature/`.

## SPEC.md Structure

See `references/spec-template.md` for full template.

**Required sections:**
- **Overview** - Module purpose (1-2 sentences)
- **Current State** - Shipped features
- **Planned** - Approved upcoming work
- **Dependencies** - Wiki-links to related modules
- **History** - Changelog with spec references

**Optional sections:**
- Components, API Surface, Configuration, Known Limitations

## Obsidian Integration

### Wiki-Link Format

```markdown
# In src/modules/incidents/SPEC.md:
Depends on: [[chat/SPEC|Chat]], [[events/SPEC|Events]]
See also: [[docs/architecture/Real-time Sync]]
```

### Graph Configuration

Set Obsidian vault to project root. Add `.obsidianignore`:
```
node_modules/
.next/
dist/
*.log
```

Color groups in graph settings:
- 🔵 `path:src/modules/` - Module specs
- 🟢 `path:docs/architecture/` - Cross-cutting
- 🟡 `path:specs/` - Active work

## spec-kit Commands Reference

| Command | Purpose |
|---------|---------|
| `/speckit.constitution` | Define project principles |
| `/speckit.specify` | Create feature specification |
| `/speckit.clarify` | Identify underspecified areas |
| `/speckit.plan` | Technical implementation plan |
| `/speckit.tasks` | Break into actionable tasks |
| `/speckit.implement` | Execute implementation |
| `/speckit.analyze` | Cross-artifact consistency check |

## Executive Workflow

Executives edit `SPEC.md` files directly:

```markdown
## Planned
> 🎯 **Approved by**: @name | **Target**: Q1 2026

### Feature Name
{Requirements in plain language}
- Acceptance criterion 1
- Acceptance criterion 2
```

Engineering picks up `## Planned` items and runs spec-kit workflow.

## Cross-Cutting Features

For features spanning multiple modules, create hub docs:

```
docs/architecture/
└── Alerting.md
```

```markdown
# Alerting System

## Affected Modules
- [[incidents/SPEC|Incidents]] - Alert triggers
- [[chat/SPEC|Chat]] - Alert delivery
- [[drones/SPEC|Drones]] - Aerial alerts

## Active Spec
- [[specs/045-unified-alerts/spec|Unified Alerts]]
```

## Best Practices

1. **One SPEC.md per module** - Single source of truth
2. **Planned section = contract** - Executives write what, engineers write how
3. **Graduate promptly** - Don't let specs/ accumulate
4. **Link bidirectionally** - Module ↔ Spec ↔ Architecture
5. **Review bootstrapped specs** - AI drafts need human validation
