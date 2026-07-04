# 14. DEVELOPMENT GUIDELINES

---

# 1. Purpose

This document defines the official development guidelines for the Survivors Lords ECS Framework.

Unlike the architecture documents, which define the technical design of the framework, and the Implementation Roadmap, which defines the order of implementation, this document establishes **how the framework must be developed** on a day-to-day basis.

These guidelines exist to ensure that all contributors produce code with consistent quality, maintainability, determinism, and long-term stability.

Every contributor is expected to understand and follow these guidelines before contributing to the project.

---

# 2. Scope

These guidelines apply to every repository that belongs to the Survivors Lords Framework, including:

- Runtime
- ECS
- Scheduler
- Registries
- Query Engine
- Event Bus
- Save System
- Multiplayer
- Tooling
- Editor integrations
- Testing
- Documentation

The rules defined here apply equally to production code, internal utilities, examples, benchmarks, and tests unless explicitly stated otherwise.

---

# 3. Development Philosophy

The Survivors Lords Framework is intended to serve as the technical foundation for multiple years of game development.

Consequently, implementation decisions should always prioritize:

- correctness over speed of implementation;
- maintainability over cleverness;
- determinism over convenience;
- explicitness over implicit behavior;
- readability over unnecessary optimization;
- architecture consistency over local improvements.

Short-term gains must never compromise the long-term health of the project.

---

# 4. Core Engineering Principles

Every implementation must follow these principles.

---

## 4.1 Architecture Is the Source of Truth

Architecture documents define the intended design.

Implementation must conform to architecture.

Developers should never modify architectural behavior during implementation without an approved architecture revision.

---

## 4.2 Determinism First

The framework is designed around deterministic execution.

Every implementation should preserve:

- deterministic scheduling;
- deterministic ECS behavior;
- deterministic serialization;
- deterministic networking;
- deterministic event ordering;
- deterministic query execution.

Non-deterministic behavior must never be introduced accidentally.

---

## 4.3 Simplicity Before Optimization

Correctness is implemented first.

Optimization is introduced only after:

- correctness,
- validation,
- benchmarks,
- profiling.

Premature optimization is discouraged.

---

## 4.4 Explicit Dependencies

Every dependency between modules should be intentional and visible.

Hidden dependencies create maintenance problems.

Circular dependencies are prohibited.

---

## 4.5 Single Responsibility

Each module should have one clearly defined responsibility.

Modules should not accumulate unrelated functionality over time.

---

## 4.6 Stable Public APIs

Public APIs should evolve carefully.

Breaking changes should be rare, deliberate, documented, and versioned.

---

# 5. Code Organization

The repository should remain organized according to the architecture.

Each subsystem should reside in its own module or package.

Example hierarchy:

```text
Runtime/
ECS/
Scheduler/
Registries/
Query/
Events/
Save/
Networking/
Tools/
Tests/
Benchmarks/
Documentation/
Examples/
```

Cross-module implementation should be minimized.

---

# 6. Source File Organization

Each source file should contain a coherent unit of functionality.

Avoid extremely large source files.

Recommended limits:

- headers/interfaces: focused and concise;
- implementation files: logically grouped;
- avoid "miscellaneous" files.

If a file becomes difficult to navigate, it should be split.

---

# 7. Naming Conventions

Naming must be consistent throughout the framework.

Good names reduce documentation requirements.

---

## 7.1 General Rules

Names should be:

- descriptive;
- unambiguous;
- consistent;
- domain-oriented.

Avoid abbreviations unless universally recognized.

---

## 7.2 Types

Types should use clear nouns.

Examples:

```text
Entity
ComponentRegistry
SystemScheduler
QueryDescriptor
SnapshotWriter
```

---

## 7.3 Functions

Functions should describe actions.

Examples:

```text
CreateEntity()

DestroyEntity()

RegisterComponent()

ExecuteSchedule()

SerializeWorld()
```

---

## 7.4 Variables

Variables should describe their purpose.

Avoid meaningless names such as:

```text
data
temp
value
object
thing
foo
bar
```

unless their scope is extremely limited.

---

## 7.5 Constants

Constants should clearly indicate immutable values.

Configuration constants should be centralized.

Magic numbers are prohibited.

---

# 8. Public API Design

Public APIs represent long-term contracts.

Before exposing an API, developers should verify:

- Is this interface necessary?
- Can this remain stable?
- Is ownership clearly defined?
- Is lifetime obvious?
- Is misuse difficult?

If the answer to any question is "no", the API should be redesigned before publication.

---

# 9. Internal APIs

Internal APIs may evolve more rapidly.

However, they should still:

- follow consistent naming;
- remain documented;
- include validation where appropriate;
- avoid unnecessary complexity.

Internal does not mean undocumented.

---

# 10. Dependency Management

Dependencies should always point toward lower-level modules.

Example:

```text
Runtime
↓

ECS
↓

Scheduler
↓

Query
↓

Events
↓

Save

↓

Networking
```

Reverse dependencies are prohibited.

Feature modules must never introduce new dependencies into foundational layers.

---

# 11. Error Handling

Errors should be explicit.

Silent failures are discouraged.

Developers should distinguish between:

- recoverable errors;
- programmer errors;
- fatal failures.

Each category should follow the architecture-defined error handling strategy.

---

## 11.1 Validation

Validate inputs whenever invalid usage could compromise framework integrity.

Validation should occur as early as practical.

---

## 11.2 Assertions

Assertions should detect impossible states.

Assertions should not replace runtime validation.

---

## 11.3 Logging

Every significant failure should generate meaningful diagnostics.

Logs should help identify:

- source;
- context;
- subsystem;
- probable cause.

Avoid vague messages.

---

# 12. Memory Management

Memory behavior should be predictable.

Developers should:

- minimize allocations during runtime;
- prefer reuse where architecture permits;
- avoid fragmentation;
- validate ownership;
- prevent leaks.

Memory optimizations must never sacrifice correctness.

---

# 13. Performance Guidelines

Performance improvements should be evidence-based.

Required workflow:

1. Measure.
2. Identify bottleneck.
3. Optimize.
4. Benchmark.
5. Verify correctness.

Every optimization should produce measurable improvement.

---

## Performance Priorities

Highest priority:

- ECS iteration
- archetype transitions
- scheduler execution
- query evaluation

Secondary priority:

- logging
- diagnostics
- tooling

---

# 14. Deterministic Behavior Requirements

The framework depends on deterministic execution.

Developers should avoid:

- unordered iteration where ordering matters;
- non-deterministic container traversal;
- reliance on undefined behavior;
- time-dependent logic outside approved timing systems;
- hidden global state.

Any source of non-determinism should be treated as a defect.

---

# 15. Thread Safety

Thread safety should follow the architecture specification.

Developers must clearly document whether a subsystem is:

- thread-safe;
- thread-compatible;
- single-threaded;
- externally synchronized.

Thread assumptions should never be implicit.

---

# 16. Logging Guidelines

Logging exists to aid development and diagnostics.

Each log entry should answer:

- What happened?
- Where?
- Why?
- What should the developer inspect next?

Logging should avoid unnecessary verbosity during normal execution while remaining sufficiently detailed for debugging.

---

# 17. Documentation Requirements

Documentation is part of implementation.

No public feature is considered complete without corresponding documentation.

Every public type, function, and subsystem should include:

- purpose;
- responsibilities;
- parameters;
- return values;
- usage notes;
- constraints;
- invariants;
- examples when beneficial.

Documentation should evolve together with the code—not after implementation is finished.
# 18. Code Style Guidelines

A consistent coding style improves readability, reduces cognitive load, and simplifies long-term maintenance.

Code should look as though it was written by a single engineering team, regardless of the number of contributors.

---

# 18.1 Readability First

Every implementation should favor readability over brevity.

Prefer:

- explicit logic;
- meaningful names;
- straightforward control flow;
- well-structured functions.

Avoid unnecessarily clever solutions.

Code is read far more often than it is written.

---

# 18.2 Function Size

Functions should perform one logical task.

Large functions are more difficult to:

- understand;
- test;
- optimize;
- review.

As a general guideline:

- short helper functions are encouraged;
- deeply nested functions should be refactored;
- repeated logic should be extracted.

---

# 18.3 Control Flow

Control flow should remain simple.

Prefer:

- early exits;
- shallow nesting;
- explicit conditions.

Avoid:

- deeply nested branches;
- excessive recursion;
- hidden side effects.

---

# 18.4 Comments

Comments should explain **why**, not **what**.

Good comments describe:

- rationale;
- assumptions;
- constraints;
- architectural intent.

Avoid comments that merely restate the implementation.

Example:

Bad

```text
Increment index.
```

Good

```text
Advance to the next chunk while preserving deterministic iteration order.
```

---

# 18.5 TODOs

Temporary TODO comments should include sufficient context.

Recommended format:

```text
TODO: Explain remaining work and why it has not yet been implemented.
```

Long-lived TODOs should reference an issue or roadmap task when applicable.

---

# 19. API Evolution Policy

Public APIs are long-term contracts.

Every modification should be evaluated for:

- compatibility;
- usability;
- documentation impact;
- testing impact;
- migration requirements.

Breaking changes should be exceptional.

---

## 19.1 Adding APIs

Before introducing a new public API, verify:

- Existing APIs cannot already solve the problem.
- The new API has a clear responsibility.
- The interface follows project conventions.
- Documentation is prepared.
- Tests are included.

---

## 19.2 Deprecation

When replacing a public API:

1. Mark the API as deprecated.
2. Document the replacement.
3. Maintain compatibility for the defined support period.
4. Remove only during an appropriate major release.

---

# 20. Testing Requirements

Testing is a mandatory part of development.

No implementation is complete without automated tests.

---

## 20.1 Testing Pyramid

The project follows a layered testing strategy.

### Unit Tests

Verify isolated behavior.

Examples:

- Entity allocation
- Component registration
- Query compilation
- Event publishing

---

### Integration Tests

Verify interaction between subsystems.

Examples:

- Scheduler + ECS
- Query Engine + ECS
- Save System + Registries
- Multiplayer + Serialization

---

### Stress Tests

Verify stability under sustained load.

Examples:

- Millions of entity operations
- Continuous schedule execution
- Large snapshot generation
- Massive event dispatch

---

### Regression Tests

Every defect fixed should introduce at least one regression test.

The regression suite should grow continuously throughout the lifetime of the framework.

---

# 21. Benchmarking Policy

Performance should be measured continuously.

Benchmarks should exist for every major subsystem.

Examples include:

- Entity creation
- Archetype migration
- Query execution
- Event dispatch
- Serialization
- Snapshot generation

Benchmark regressions should be investigated before merging changes.

---

# 22. Code Review Process

Every non-trivial contribution should undergo code review.

Reviews should evaluate:

- correctness;
- architecture compliance;
- readability;
- maintainability;
- performance impact;
- documentation;
- testing coverage.

Code review is not solely for defect detection—it is a mechanism for preserving engineering quality.

---

## 22.1 Reviewer Checklist

Reviewers should verify:

- [ ] Architecture respected
- [ ] Naming consistent
- [ ] No unnecessary complexity
- [ ] Public APIs justified
- [ ] Tests included
- [ ] Documentation updated
- [ ] Performance considered
- [ ] No hidden dependencies
- [ ] No duplicated logic
- [ ] Error handling appropriate

---

# 23. Pull Request Requirements

Every Pull Request should contain:

- clear description;
- implementation summary;
- affected modules;
- testing performed;
- documentation updates;
- known limitations (if any).

Large Pull Requests should be avoided whenever practical.

Incremental changes simplify review and reduce integration risk.

---

# 24. Continuous Integration Expectations

Every contribution should pass the complete CI pipeline before merging.

Minimum requirements:

- formatting verification;
- static analysis;
- compilation;
- unit tests;
- integration tests.

Nightly pipelines should additionally execute:

- stress tests;
- benchmarks;
- determinism verification;
- memory validation.

---

# 25. Refactoring Policy

Refactoring is encouraged when it improves maintainability without changing architecture.

Every refactoring should satisfy the following conditions:

- behavior preserved;
- tests remain green;
- benchmarks do not regress significantly;
- documentation updated if affected.

Large refactors should be isolated from feature work.

---

## 25.1 Safe Refactoring Workflow

1. Establish baseline tests.
2. Perform refactor.
3. Execute full test suite.
4. Compare benchmark results.
5. Update documentation.
6. Merge only after review.

---

# 26. Technical Debt Management

Technical debt should be tracked explicitly.

Developers should avoid:

- postponing known defects indefinitely;
- accumulating undocumented workarounds;
- introducing shortcuts that conflict with architecture.

When technical debt is accepted intentionally, it should be:

- documented;
- justified;
- prioritized for future resolution.

---

# 27. Dependency Rules

Module dependencies must remain acyclic.

Allowed dependency direction:

```text
Infrastructure
        ↓
Runtime
        ↓
ECS
        ↓
Scheduler
        ↓
Registries
        ↓
Query Engine
        ↓
Event Bus
        ↓
Save System
        ↓
Multiplayer
```

Higher-level modules may depend on lower-level modules.

Lower-level modules must never depend on higher-level modules.

---

# 28. Definition of Done

A development task is considered complete only when all applicable criteria have been satisfied.

---

## Implementation

- Feature implemented
- Architecture respected
- Coding standards followed

---

## Validation

- Unit tests passing
- Integration tests passing
- No known regressions

---

## Documentation

- Public APIs documented
- Internal documentation updated
- Developer guides updated if necessary

---

## Review

- Code reviewed
- Feedback addressed
- CI passing

---

## Performance

- Benchmarks executed (when applicable)
- No unacceptable regressions detected

---

Only after satisfying all criteria should a task be considered complete.

---

# 29. Contributor Responsibilities

Every contributor is responsible for:

- understanding the architecture before implementing changes;
- following these development guidelines;
- maintaining deterministic behavior;
- writing appropriate tests;
- updating documentation;
- participating constructively in reviews;
- reporting technical risks early.

Quality is a shared responsibility.

---

# 30. Long-Term Maintenance Principles

The Survivors Lords ECS Framework is intended to evolve over many years.

Long-term maintainability requires continuous discipline.

Future contributors should strive to:

- preserve architectural integrity;
- minimize unnecessary complexity;
- favor incremental improvements;
- maintain comprehensive automated testing;
- keep documentation synchronized with implementation;
- avoid introducing breaking changes without clear justification.

The framework should become easier to understand over time—not more difficult.

---

# 31. Final Statement

These Development Guidelines establish the engineering standards expected throughout the implementation and maintenance of the Survivors Lords ECS Framework.

Together with the Architecture documents and the Implementation Roadmap, they define a complete engineering process covering:

- system design;
- implementation;
- testing;
- review;
- documentation;
- optimization;
- release preparation;
- long-term maintenance.

Adherence to these guidelines ensures that the framework remains deterministic, maintainable, extensible and production-ready throughout its lifecycle, providing a stable foundation for the continued development of Survivors Lords.
