---
name: design-diagram
description: Create or update architecture, application design and flow diagrams (or a combined one) as draw.io files exported to PNG. Use for any new application design or design modification, or when the user asks for an architecture, application design, data-flow or design diagram.
---

# Design diagram

Kinds (user may want one or a combination):
- Architecture: static structure of the system: infrastructure/services, tiers, zones, dependencies, trust boundaries, data stores.
- Application design: inside the app: layers/modules/components, responsibilities, patterns, key interfaces, what depends on what.
- Flow: a scenario path through the system (data enters, each hop, where it leaves).
- Combined: structure first, then flows over it. One page per kind or one diagram with sections; keep component names, positions, styles identical across them so flows read as paths through the architecture.
Not covered (sequence, ER, state): say so, offer the closest of the above.
Output: `docs/design/<name>.drawio` + `.png`. Update existing files in place; no stale copies.

## Procedure
1. Scoping chat (mandatory, before drawing). One short message, fellow-engineer tone, only unanswered questions, max 4: which kind(s) (architecture, application design, flow, or all combined) and which flows start to finish; who it is for and why; level (business steps, or real systems/services + stack); what must stand out (auth, security, storage, failure paths). Never ask about shapes, colours, layout or per-box detail. At most one follow-up. Then state in 1-2 lines what you will draw and draw it, no further approval.
2. Flows from the answers. For an existing codebase, verify every box and arrow against the code (grep imports/routes) before drawing; a guessed arrow is a wrong diagram. Use real names only; if stack unknown, say "illustrative".
3. Write the `.drawio` XML (explicit geometry, html labels, `<br>` for description line); script it if many cells.
4. Export once: `drawio -x -f png -s 2 -b 20 -o docs/design/<name>.png docs/design/<name>.drawio` (pages: `-p <n>`, `<name>-<n>.png`; `--all-pages` fails for PNG).
5. View PNG once, fix in one pass. Check: START/end and decision exits labelled; every arrow labelled + numbered; no line over box/label; no clipped/overlapping text (labels fit gaps); icons render; legend matches styles; title + subtitle.
6. Reply at design level, short: flows, patterns, security points, one open question, PNG path.

## Kind rules
- Architecture: group components into tiers/zones/containers; arrows are dependencies or calls labelled with protocol/purpose; mark trust boundaries, data stores, external systems; no step numbers unless a flow is overlaid.
- Application design: layers as horizontal bands (top = entry, bottom = data), modules as boxes inside, arrows only for allowed dependencies (downward), pattern tags, one-line responsibility per box; show key interfaces/contracts between layers; no step numbers.
- Flow: rules below (steps, numbered arrows, START/end).
- Combined: overview first (architecture and/or application design), then one flow section per scenario; flows use only the components they touch, at the same positions.

## Content
- One section per flow/scenario (same component positions across sections); split diagrams when crowded. One abstraction level, one direction.
- Box: bold name + 3-8 word description. Tag patterns ("Adapter", "CQRS") small on the box. Consistent naming.
- Arrow: says WHAT moves (protocol/route/payload when systems are shown), step badge on the source icon/box corner (not on the line). Replies return on same path; draw them only if they carry something key (dashed).
- Controls the request passes through but does not end at (WAF, authoriser): on the path, DOTTED arrows in and out (`dashed=1;dashPattern=1 4`).
- Key points (auth, secrets, data integrity, origin lock): small note joined to the arrow by dotted line ending in a dot. Auth note (red): who issues the token, who checks it and how, where it is stored, what happens if missing.
- Mark trust boundaries (dashed red), auth/validation/encryption/secrets. Zones shaded behind the path when systems are shown (Internet, edge, public subnet, private app, data, managed); containers where real (VPC, cluster).
- Same meaning = same shape/size/colour/line style; colour never the only cue. Changes: new green border, changed orange, removed in a note, legend entry.
- Optional monospace lines (13px Courier New, #2f4b7c: file, route, table) only for app internals, confirmed in code.

## Shapes
- Generic: pill/`ellipse` start-end; `rounded=1;arcSize=12` step; `shape=process` sub-process; `rhombus` decision; `shape=cylinder3` DB; `shape=document` file; `shape=queue`; `shape=parallelogram` I/O; `shape=cloud` external; `shape=actor` user; `shape=hexagon` gateway; `shape=offPageConnector`; `multiple=1;` many instances.
- Product icons only when a specific product is meant. `shape=mxgraph.aws4.resourceIcon;resIcon=mxgraph.aws4.<name>;strokeColor=#ffffff;aspect=fixed;html=1;verticalLabelPosition=bottom;verticalAlign=top;whiteSpace=wrap;labelWidth=190;` Tested names: waf, cloudfront, application_load_balancer, fargate, ecs, rds, rds_postgresql_instance, cognito, secrets_manager, client, user, users, internet, route_53, s3, elasticache (`elastic_container_service` is blank). Fills: network/CDN #8C4FFF, compute #ED7100, database #C925D1, security/identity #DD344C, client #232F3E, S3 #277116. Direct form also works (`shape=mxgraph.aws4.bucket`). Other families (`kubernetes`, `azure`, `gcp2`, `flowchart`): confirm name renders; never guess. Icons 60-78px, label below, one size and one vendor style.
- Sections: `rounded=1;container=1;collapsible=0;verticalAlign=top;` tinted, one hue per flow, lighter than contents.

## Look
- Palette light/dark: blue #dae8fc/#6c8ebf, green #d5e8d4/#82b366, orange #ffe6cc/#d79b00, red #f8cecc/#b85450, purple #e1d5e7/#9673a6, grey #f5f5f5/#666666. Helvetica, dark text.
- Boxes: `rounded=1;arcSize=12;shadow=1;html=1;whiteSpace=wrap;spacing=6;`, one style string and size per role (~220x100 for 3 lines).
- Text: boxes 14, edge labels 13, section titles 16, title 26, subtitle/legend 14; never <13.
- Grid 10px; gaps >=60 between boxes, >=40 in containers; 3-line arrow labels need >=140px gaps (icon pitch >=230). Vertical edges must not run through titles; 5-line boxes need row pitch ~170-180.
- Connectors: `edgeStyle=orthogonalEdgeStyle;rounded=1;jettySize=auto;curved=0;endArrow=block;endFill=1;strokeWidth=2;labelBackgroundColor=#ffffff;` with explicit exit/entry points and waypoints; never over boxes or labels. Solid data, dashed async/optional/reply, red security/authenticated. No `flowAnimation=1` (exports dashed). Crossings: reorder first, else `jumpStyle=arc;jumpSize=10;`. 3+ edges on one box: spread entry points. Bidirectional only if truly two-way.
- Legend mandatory: bordered box outside the flows, same styles as the diagram, one-line meanings. Title + one-line subtitle top.
- Optional layers (Flow, Security, Changes, Legend); container children use container as `parent`; meaningful cell ids.
