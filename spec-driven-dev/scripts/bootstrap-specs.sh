#!/bin/bash
# Bootstrap SPEC.md files for existing modules
# Usage: ./bootstrap-specs.sh <modules-dir> [output-dir]
#
# This script creates minimal draft SPEC.md files by analyzing module structure.
# AI agents should review and enhance these drafts.

set -e

MODULES_DIR="${1:?Usage: $0 <modules-dir> [output-dir]}"
OUTPUT_DIR="${2:-$MODULES_DIR}"
DATE=$(date +%Y-%m-%d)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Bootstrapping SPEC.md files...${NC}"
echo "Modules dir: $MODULES_DIR"
echo "Output dir: $OUTPUT_DIR"
echo ""

# Process each module directory
for module_path in "$MODULES_DIR"/*/; do
    [ -d "$module_path" ] || continue
    
    module_name=$(basename "$module_path")
    spec_file="$OUTPUT_DIR/$module_name/SPEC.md"
    
    # Skip if SPEC.md already exists
    if [ -f "$spec_file" ]; then
        echo -e "${YELLOW}SKIP${NC} $module_name (SPEC.md exists)"
        continue
    fi
    
    echo -e "${GREEN}INIT${NC} $module_name"
    
    # Analyze module structure
    components=""
    types=""
    services=""
    hooks=""
    
    # Find components
    if [ -d "$module_path/components" ]; then
        components=$(find "$module_path/components" -name "*.tsx" -o -name "*.ts" 2>/dev/null | head -10)
    fi
    
    # Find types
    if [ -d "$module_path/types" ]; then
        types=$(find "$module_path/types" -name "*.ts" 2>/dev/null | head -5)
    fi
    
    # Find services
    if [ -d "$module_path/services" ]; then
        services=$(find "$module_path/services" -name "*.ts" 2>/dev/null | head -5)
    fi
    
    # Find hooks
    hooks=$(find "$module_path" -name "use*.ts" -o -name "use*.tsx" 2>/dev/null | head -5)
    
    # Generate component table
    component_table=""
    if [ -n "$components" ]; then
        component_table="## Components\n\n| Component | Purpose | Location |\n|-----------|---------|----------|\n"
        while IFS= read -r file; do
            [ -z "$file" ] && continue
            name=$(basename "$file" | sed 's/\.[^.]*$//')
            rel_path=$(realpath --relative-to="$module_path" "$file" 2>/dev/null || echo "$file")
            component_table+="| $name | _TODO: describe_ | \`$rel_path\` |\n"
        done <<< "$components"
    fi
    
    # Title case the module name
    title_name=$(echo "$module_name" | sed -r 's/(^|-)([a-z])/\U\2/g' | sed 's/-/ /g')
    
    # Create SPEC.md
    mkdir -p "$(dirname "$spec_file")"
    cat > "$spec_file" << EOF
# $title_name

> ⚠️ **Status**: Draft - needs review
> **Generated**: $DATE | **Reviewed by**: _pending_

## Overview

_TODO: Describe what this module does and why it exists._

## Current State

_TODO: List currently implemented features._

- Feature 1
- Feature 2

$(echo -e "$component_table")

## Dependencies

_TODO: Add wiki-links to related modules._

- [[{module}/SPEC|{Module Name}]] - {relationship}

## Planned

_Empty - ready for requirements_

## History

- $DATE: Bootstrapped from existing codebase
EOF

    echo "  Created: $spec_file"
done

echo ""
echo -e "${GREEN}Done!${NC} Review generated files and fill in TODOs."
echo "Tip: Use AI to analyze code and enhance drafts."
