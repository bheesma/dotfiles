---
name: design-diagram
description: Create or update flow-style architecture/design diagrams as draw.io files exported to PNG. Use for any new application design or design modification, or when the user asks for an architecture, data-flow or design diagram.
---

# Design diagram (flow-first)

Output: `docs/design/<name>.drawio` (editable source) and `docs/design/<name>.png`. Create the folder if missing. Update the existing file for modifications; never leave stale copies.

## Principles
- Diagrams are FLOWS, not component inventories. Show where data enters, each hop it takes, and where it leaves (stores, UIs, APIs, alerts).
- One section (swimlane/container) per flow, in one diagram or several diagrams if it gets crowded. Typical sections: ingestion/processing, request/query, monitoring & metrics, security (auth, trust boundaries, secrets), plus any domain-specific flow.
- Layout reads left-to-right (or top-to-bottom) within a section; start nodes are visually distinct and labelled "START"/entry.
- Every arrow is labelled with WHAT moves (e.g. "repo files", "parsed symbols", "query JSON"). Number steps (1, 2, 3...) within each flow.
- Every box has a name PLUS a short meaningful description (3-8 words) on a second line, e.g. "Converter\ncsv -> excel" or "Normalizer\nchange to common format". Show key and relevant features; skip trivial ones (UI toggles, cosmetic options).
- Name the design pattern where one is used (e.g. "Adapter", "CQRS", "Pipeline", "Observer") as a small tag on the box.
- Mark trust boundaries and where auth, validation, encryption or secrets handling occur.
- Colour/shape legend in a corner: external source, processing step, data store, user-facing entry, security control. Keep a consistent palette.
- For modifications: highlight new elements (green border) and changed ones (orange border) and add a legend entry; mention removed items in a note.
- No code-level detail (functions, files) unless it is the architecture.

## Visual quality (required)
- Use proper draw.io shapes, not plain rectangles everywhere: `shape=cylinder3` for databases, `shape=document`/`note` for files, `shape=cloud` for external systems, `shape=actor` or `shape=mxgraph.azure.user` for users, `shape=hexagon` for gateways/brokers, `shape=process` or `rounded=1` for steps, `shape=queue`/`mxgraph.flowchart.*` where apt, `shape=step`/`shape=parallelogram` for I/O, `swimlane` or `rounded=1;container=1` for sections, `shape=mxgraph.aws4.*`/`mxgraph.kubernetes.*` etc. only when the real product is meant.
- Rounded boxes (`rounded=1;arcSize=12`), soft drop shadows (`shadow=1`), consistent fill/stroke pairs (light fill, darker stroke of same hue, e.g. blue #dae8fc/#6c8ebf, green #d5e8d4/#82b366, orange #ffe6cc/#d79b00, red #f8cecc/#b85450, purple #e1d5e7/#9673a6, grey #f5f5f5/#666666), dark readable text, Helvetica, bold names with normal-weight descriptions (use html labels).
- Text size (keep it large; the PNG is read at normal zoom): box text 14px, edge labels 13px, section titles 16px, diagram title 26px, subtitle/legend 14px; never below 13px. Size boxes for it (about 220x100 for a 3-line box) and widen gaps so edge labels still fit.
- Section containers: tinted background, bold title bar, lighter than the boxes inside; give each flow its own hue.
- Connectors: `edgeStyle=orthogonalEdgeStyle;rounded=1;jettySize=auto;` with `endArrow=block;endFill=1;` (`curved=0`). Anchor with explicit `exitX/exitY/entryX/entryY` and add waypoints so lines run in the gaps between boxes and NEVER cross or run over boxes or labels. Use dashed lines (`dashed=1`) for async/metrics/control flow, solid for data flow, thick (`strokeWidth=2`) for the main path, red for security-relevant paths. Edge labels get a white label background (`labelBackgroundColor=#ffffff`).
- Lay out on a grid with generous gaps (>=60px between boxes, >=40px inside containers); align boxes in rows/columns; avoid crossing edges by ordering nodes sensibly.
- Legend is mandatory: a bordered box in a corner (outside flow areas) showing every shape, colour, and line style used, with one-line meanings.
- Add a title and one-line subtitle at top.
- After export, view the PNG and specifically check: no line over a box, no overlapping labels, no clipped text, shadows present, legend complete.

## Procedure
0. Walkthrough first (new designs and major changes): say the plan in 1-2 lines and ask to go one flow at a time. Then narrate each flow in a short paragraph (actor, action, data moved, where stored/validated) and ask "are we good?". Wait for the answer, revise, move on. Draw only after all flows are agreed. Keep every message short; ask at most one question per turn.
1. Gather the flows from the user's description or existing project (read lightly; ask only about design/security gaps).
2. Write the `.drawio` XML (mxfile/mxGraphModel, explicit geometry, `html=1;whiteSpace=wrap` styles, labels with `<br>` for the description line, edges with labels). Size boxes so text fits; leave generous spacing so arrows do not cross boxes.
3. Export once: `drawio -x -f png -s 2 -b 20 -o docs/design/<name>.png docs/design/<name>.drawio`
4. View the PNG once; check no clipped text, no overlapping boxes, flows readable, every flow has a clear start. Fix in one pass only.
5. Reply to the user at design level: list the flows shown, patterns used, security points, and open design questions. Give the PNG path. No code talk.
