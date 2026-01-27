# SPEC.md Template

Use this template for module specification files. Adapt sections as needed.

---

```markdown
# {Module Name}

> {One-line description of module purpose}

## Overview

{2-3 sentences explaining what this module does and why it exists.}

## Current State

Features currently implemented and shipped:

- {Feature 1} - {brief description}
- {Feature 2} - {brief description}
- {Feature 3} - {brief description}

## Planned

> 🎯 **Approved by**: {name/role} | **Target**: {date/quarter}

### {Planned Feature Name}

{Description of what needs to be built}

**Acceptance Criteria:**
- [ ] {Criterion 1}
- [ ] {Criterion 2}
- [ ] {Criterion 3}

## Dependencies

Modules this depends on or integrates with:

- [[{other-module}/SPEC|{Other Module}]] - {how it's used}
- [[{another-module}/SPEC|{Another Module}]] - {integration point}
- [[docs/architecture/{concept}|{Concept}]] - {relationship}

## Components

| Component | Purpose | Location |
|-----------|---------|----------|
| {ComponentName} | {What it does} | `components/{file}.tsx` |
| {ServiceName} | {What it does} | `services/{file}.ts` |

## API Surface

### Endpoints (if applicable)

| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/{resource}` | {description} |
| POST | `/api/{resource}` | {description} |

### Hooks/Context (if applicable)

- `use{Module}()` - {what it provides}
- `{Module}Context` - {what state it holds}

## Configuration

Environment variables or config options:

| Variable | Required | Description |
|----------|----------|-------------|
| `{VAR_NAME}` | Yes/No | {what it controls} |

## Known Limitations

- {Limitation 1}
- {Limitation 2}

## History

| Date | Change | Spec |
|------|--------|------|
| YYYY-MM-DD | {What changed} | spec-NNN |
| YYYY-MM-DD | Initial implementation | spec-NNN |
```

---

## Bootstrap Template (Minimal)

For AI-generated drafts, start with this minimal version:

```markdown
# {Module Name}

> ⚠️ **Status**: Draft - needs review
> **Generated**: {date} | **Reviewed by**: _pending_

## Overview

{AI-inferred purpose}

## Current State

{Features detected from code analysis}

- {Detected feature 1}
- {Detected feature 2}

## Components

| Component | Purpose | Location |
|-----------|---------|----------|
| {Detected} | {Inferred} | `{path}` |

## Dependencies

{Inferred from imports}

- [[{module}/SPEC|{Module}]] - {usage}

## Planned

_Empty - ready for requirements_

## History

- {date}: Bootstrapped from existing codebase
```

---

## Section Guidelines

### Overview
- Keep it brief (2-3 sentences max)
- Focus on WHAT and WHY, not HOW
- Avoid implementation details

### Current State
- List shipped, working features
- Use present tense ("Handles X", "Supports Y")
- Be specific but concise

### Planned
- Include approval/ownership info
- Write acceptance criteria as checkboxes
- Executives should be able to write this section

### Dependencies
- Use wiki-links for Obsidian graph
- Explain the relationship, not just the link
- Include both runtime and build-time dependencies

### History
- Reverse chronological (newest first)
- Reference spec numbers for traceability
- Keep entries brief
