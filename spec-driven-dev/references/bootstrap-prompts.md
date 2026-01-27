# Bootstrap Prompts & Analysis Guide

Detailed instructions for AI-assisted SPEC.md generation.

## What to Look For (Analysis Checklist)

### 1. Module Purpose (for Overview)

Infer from:
- **Folder name** - Usually descriptive (`incident-manager` = incident management)
- **Main export** - What's the primary component/hook/service?
- **README.md** - If exists, extract purpose statement
- **JSDoc comments** - Top-level file comments often describe intent
- **Import consumers** - Who imports this module? That reveals its role.

### 2. Features (for Current State)

Look for:
- **Components** - Each component often = one feature
  - `IncidentEditDialog.tsx` → "Incident editing dialog"
  - `MediaGallery.tsx` → "Media gallery display"
- **Hooks** - Each `use*.ts` = a capability
  - `useConversationCases.ts` → "Case state management"
- **Service calls** - API functions reveal backend features
  - `updateIncident()` → "Incident updates"
  - `fetchProtocols()` → "Protocol fetching"
- **Type definitions** - Complex types = feature boundaries
  - `ConversationCase` type → "Case management"
- **Event handlers** - `onClick`, `onSubmit` reveal user actions
- **State variables** - `useState` calls show what's being managed

### 3. Dependencies (for wiki-links)

**Code patterns to detect:**
```typescript
// Direct module import → strong dependency
import { X } from '@/modules/other-module/...'
// → [[other-module/SPEC|Other Module]] - imports X

// Service import → backend integration
import { someService } from '@/services/foo.service'
// → `@/services/foo.service` - {what it does}

// Context import → shared state dependency
import { useCompanyResources } from '@/context/...'
// → Note in Dependencies as shared context

// Type-only import → weak dependency (mention but lower priority)
import type { SomeType } from '@/modules/other/...'
```

**Relationship descriptions (be specific):**
- ❌ Bad: `[[chat/SPEC|Chat]] - related`
- ✅ Good: `[[chat/SPEC|Chat]] - incident-linked conversation threads`

### 4. Component Inventory

Build table from file listing:
```
| Component | Purpose | Location |
|-----------|---------|----------|
```

**Purpose inference:**
- `*Dialog.tsx` → Modal/dialog for editing/creating
- `*List.tsx` → List/grid display
- `*Panel.tsx` → Sidebar or detail panel
- `*Form.tsx` → Input form
- `*Card.tsx` → Summary card display
- `*View.tsx` → Full page/view
- `*Provider.tsx` → Context provider
- `use*.ts` → Hook (state/logic extraction)

---

## Single Module Analysis Prompt

```
Analyze src/modules/{module-name}/ and generate SPEC.md.

## Analysis Steps

1. **List all files** in the module directory (recursive)

2. **Read key files** (prioritize):
   - index.ts/tsx (main exports)
   - Types files (*.types.ts, types/*.ts)
   - Main components (largest .tsx files)
   - Hooks (use*.ts)

3. **Extract information**:
   - Purpose: What problem does this module solve?
   - Features: What can users/operators do with it?
   - Components: What UI elements exist?
   - Dependencies: What other modules/services does it use?

4. **Generate SPEC.md** following template at references/spec-template.md

## Output Requirements

- Overview: 2-3 sentences, focus on WHAT and WHY
- Current State: Bullet list of shipped features (verb phrases)
- Components table: Name | Purpose | Relative path
- Dependencies: Wiki-links with relationship descriptions
- History: Single entry with today's date

## Quality Checks

Before outputting, verify:
- [ ] No placeholder text like "Feature 1" or "_TODO_"
- [ ] All wiki-links use correct format: [[path/SPEC|Display Name]]
- [ ] Component purposes are specific, not generic
- [ ] Overview doesn't repeat the module name
```

---

## Batch Bootstrap Prompt

```
Bootstrap SPEC.md for all modules in src/modules/.

## Process

For each directory in src/modules/:
1. Check if SPEC.md exists → skip if yes
2. Run single module analysis (see above)
3. Write SPEC.md to module directory
4. Track: created, skipped, failed

## Output Format

After completion, report:
- ✅ Created: {list}
- ⏭️ Skipped (exists): {list}  
- ❌ Failed: {list with reasons}
- 📋 Needs human review: {modules with low confidence}

## Parallelization

If possible, analyze modules in parallel. Dependencies between modules 
don't affect individual SPEC.md generation.
```

---

## Enhance Draft Prompt

```
Enhance the draft SPEC.md at src/modules/{module}/SPEC.md.

## Current State

The file has skeleton content with TODOs or generic placeholders.

## Enhancement Steps

1. **Read the draft** to understand current structure

2. **Analyze actual code** in the module:
   - Read component files for feature details
   - Check imports for accurate dependencies
   - Look at types for data model understanding

3. **Replace placeholders**:
   - "_TODO: Describe..._" → actual description
   - "Feature 1, Feature 2" → real feature list
   - "[[{module}/SPEC|{Module}]]" → actual wiki-links

4. **Add missing sections** if applicable:
   - API Surface (if module has API endpoints)
   - Configuration (if env vars or config needed)
   - Data Types (if complex types worth documenting)

5. **Remove draft warning** when complete:
   - Delete the "⚠️ Status: Draft" line
   - Update "Reviewed by" if applicable

## Quality Bar

Enhanced SPEC.md should:
- Have zero TODOs or placeholders
- Accurately reflect current code
- Link to real modules that exist
- Be useful for a new developer onboarding
```

---

## Dependency Graph Prompt

```
Generate a dependency graph from all SPEC.md files.

## Steps

1. Find all SPEC.md files: `find src/modules -name "SPEC.md"`

2. For each file, extract:
   - Module name (from path)
   - Dependencies (from [[wiki-links]])

3. Build graph edges:
   - Source: current module
   - Target: linked module
   - Label: relationship description

4. Output as Mermaid:
   ```mermaid
   graph TD
     incident-manager --> chat
     incident-manager --> events
     chat --> workspace
   ```

5. Analysis:
   - Circular dependencies (A→B→A)
   - Orphans (no incoming or outgoing links)
   - Hubs (many connections - likely core modules)
```

---

## Architecture Doc Prompt

```
Generate docs/architecture/{topic}.md from existing SPEC.md files.

Topic: {e.g., "Real-time Sync"}

## Analysis

1. Search all SPEC.md files for mentions of topic
2. Identify which modules participate
3. Trace data/event flow between them

## Output Structure

# {Topic}

## Overview
{What this cross-cutting concern does}

## Modules Involved
- [[module-a/SPEC|Module A]] - {role in this concern}
- [[module-b/SPEC|Module B]] - {role in this concern}

## Data Flow
{Mermaid diagram showing flow}

## Key Decisions
- {Decision 1 and rationale}
- {Decision 2 and rationale}

## Related
- [[docs/decisions/ADR-NNN|Relevant ADR]]
```
