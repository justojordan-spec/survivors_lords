# 18. CODING STANDARDS

---

# 1. Purpose

This document defines the official coding standards for the Survivors Lords ECS Framework.

Its objective is to ensure that all source code produced for the project is consistent, readable, maintainable, deterministic, and aligned with the framework architecture.

These standards complement the Development Guidelines by defining concrete implementation conventions rather than engineering processes.

Every contributor is expected to follow these standards throughout the lifetime of the project.

---

# 2. Scope

These coding standards apply to every source file in the framework, including:

* Runtime
* ECS Core
* Scheduler
* Registry Systems
* Query Engine
* Event Bus
* Save System
* Multiplayer
* Tooling
* Tests
* Benchmarks
* Examples
* Internal utilities

Generated code is exempt unless explicitly configured otherwise.

---

# 3. Coding Philosophy

Source code should be written primarily for human readers.

Compiler optimization is important, but maintainability takes precedence unless profiling demonstrates a measurable benefit.

Every implementation should aim to be:

* clear;
* deterministic;
* explicit;
* predictable;
* modular;
* easy to review.

Code should communicate intent without requiring external explanation.

---

# 4. Fundamental Principles

Every implementation should respect the following principles.

---

## 4.1 Correctness First

Correct behavior always takes precedence over optimization.

An optimized implementation that produces incorrect results is considered defective.

---

## 4.2 Readability Over Cleverness

Avoid unnecessarily complex language constructs.

Straightforward code is preferred over highly compact or overly abstract solutions.

Future maintainers should be able to understand the implementation quickly.

---

## 4.3 Consistency

Equivalent problems should be solved using equivalent solutions.

Consistency throughout the codebase is more valuable than isolated stylistic improvements.

---

## 4.4 Explicit Intent

Code should make ownership, lifetime, side effects, and responsibilities obvious.

Implicit behavior should be minimized.

---

## 4.5 Architecture Compliance

Implementation details must never contradict the approved architecture.

Whenever uncertainty exists, the architecture documents take precedence over coding preferences.

---

# 5. Project Organization

Source code should mirror the architectural structure of the framework.

Representative layout:

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
```

Subsystem boundaries should remain clearly defined.

---

# 6. File Organization

Each file should have a single well-defined responsibility.

Avoid:

* excessively large files;
* unrelated functionality;
* mixed abstraction levels.

If a file becomes difficult to navigate, it should be divided into smaller logical units.

---

## Recommended File Contents

A typical source file should contain:

1. license header (if applicable);
2. imports/includes;
3. constants;
4. type declarations;
5. helper functions;
6. public implementation;
7. private implementation.

The organization should remain consistent throughout the repository.

---

# 7. Naming Conventions

Consistent naming significantly improves readability.

Names should communicate meaning rather than implementation.

---

## 7.1 General Rules

Names should be:

* descriptive;
* concise;
* unambiguous;
* domain-specific.

Avoid abbreviations unless they are universally recognized.

---

## 7.2 Types

Type names should use nouns.

Examples:

```text
Entity

World

Scheduler

SystemGraph

ComponentRegistry

SnapshotWriter
```

Type names should describe concepts rather than implementation details.

---

## 7.3 Interfaces

Interface names should clearly express their responsibilities.

Examples:

```text
ISerializer

IQueryProvider

ISystem

IComponentStorage
```

Naming should remain consistent throughout the project.

---

## 7.4 Functions

Functions should use verbs.

Examples:

```text
CreateEntity()

DestroyEntity()

RegisterSystem()

ExecuteSchedule()

SerializeWorld()

LoadSnapshot()
```

Function names should describe observable behavior.

---

## 7.5 Variables

Variable names should describe purpose.

Examples:

Good:

```text
entityCount

activeSystems

componentMask

snapshotVersion
```

Avoid:

```text
tmp

data

obj

x

y

foo
```

except for very limited local scope.

---

## 7.6 Constants

Constants should have meaningful names.

Magic numbers should not appear directly in implementation.

Instead:

```text
MaximumArchetypes

DefaultChunkCapacity

SnapshotVersion
```

Constants should be centralized whenever practical.

---

# 8. Formatting

Formatting should remain consistent across the entire repository.

Automated formatting tools should be used whenever available.

Formatting differences should never obscure implementation changes.

---

## General Formatting Rules

Prefer:

* consistent indentation;
* consistent spacing;
* short logical blocks;
* readable line lengths.

Avoid formatting styles that reduce readability.

---

# 9. Functions

Functions should be small and focused.

Each function should perform one logical task.

If a function begins to perform multiple unrelated responsibilities, it should be decomposed.

---

## Function Responsibilities

Good functions:

* perform one action;
* have clear inputs;
* produce clear outputs;
* avoid hidden side effects.

---

## Parameters

Parameter lists should remain concise.

Large parameter lists often indicate excessive coupling.

When appropriate, related parameters should be grouped into meaningful structures defined by the architecture.

---

# 10. Control Flow

Control flow should remain straightforward.

Prefer:

* early returns;
* guard clauses;
* shallow nesting.

Avoid deeply nested conditional logic whenever practical.

---

## Loops

Loops should have clearly defined purposes.

Loop invariants should remain easy to understand.

Nested iteration should be introduced only when necessary.

---

# 11. Comments

Comments exist to explain intent.

Good comments describe:

* why something exists;
* architectural decisions;
* non-obvious constraints;
* deterministic requirements.

Avoid comments that merely repeat the implementation.

---

## Documentation Comments

Every public API should include documentation describing:

* purpose;
* parameters;
* return value;
* constraints;
* ownership rules;
* invariants.

Documentation should evolve together with the implementation.

---

# 12. Error Handling

Errors should be handled explicitly.

Avoid silent failures.

Implementations should distinguish between:

* programmer errors;
* recoverable runtime errors;
* fatal failures.

Each category should follow the project's architecture and error-handling strategy.

---

## Validation

Validate inputs whenever invalid data could compromise framework integrity.

Validation should occur as early as practical.

Failing early generally simplifies debugging and improves reliability.
# 13. Memory Management

Memory management should be predictable, explicit, and consistent with the framework architecture.

Implementations should prioritize:

* deterministic allocation behavior;
* minimal runtime allocations;
* clear ownership;
* efficient resource reuse;
* memory safety.

Correctness always takes precedence over optimization.

---

## 13.1 Ownership

Ownership of allocated resources should always be unambiguous.

Every object should have a clearly defined owner responsible for its lifetime.

Ownership should never be inferred implicitly.

---

## 13.2 Lifetime

Object lifetime should be predictable.

Developers should avoid:

* dangling references;
* hidden ownership transfer;
* unnecessary object retention;
* unclear destruction order.

Whenever practical, lifetime should follow architectural boundaries.

---

## 13.3 Allocation Strategy

Runtime allocations should be minimized.

Whenever permitted by the architecture, prefer:

* preallocation;
* pooling;
* reusable buffers;
* contiguous storage.

Allocation-heavy code paths should be benchmarked.

---

# 14. Deterministic Programming

The framework is fundamentally deterministic.

Every implementation should preserve deterministic execution.

Avoid introducing:

* unordered iteration where order matters;
* dependency on platform-specific behavior;
* hidden global state;
* time-dependent execution outside approved systems.

Equivalent inputs should always produce equivalent outputs.

---

# 15. Thread Safety

Thread behavior should be explicit.

Each subsystem should clearly define whether it is:

* thread-safe;
* externally synchronized;
* single-threaded;
* immutable after construction.

Threading assumptions should never be implicit.

---

## Synchronization

Synchronization should be minimized.

When synchronization is required:

* document it;
* keep critical sections small;
* avoid unnecessary contention;
* preserve deterministic behavior.

---

# 16. Public API Standards

Public APIs represent long-term contracts.

Every public interface should be:

* stable;
* documented;
* intuitive;
* difficult to misuse.

Before exposing an API, verify:

* Is it necessary?
* Is it future-proof?
* Is ownership clear?
* Is lifetime obvious?
* Does it respect the architecture?

---

## API Stability

Breaking public APIs requires:

* architectural approval;
* documentation updates;
* migration guidance;
* versioning according to SemVer.

Minor implementation improvements should not unnecessarily affect public interfaces.

---

# 17. Internal APIs

Internal APIs may evolve more rapidly but should still follow project standards.

Internal code should remain:

* documented;
* readable;
* testable;
* modular.

"Internal" should never be interpreted as "temporary" or "low quality."

---

# 18. Documentation in Code

Source code documentation complements external documentation.

Every public declaration should describe:

* purpose;
* behavior;
* ownership;
* parameters;
* return values;
* invariants;
* error conditions.

Complex internal algorithms should include implementation notes where beneficial.

---

# 19. Assertions

Assertions verify assumptions that should never be violated.

They should detect:

* impossible states;
* invariant violations;
* programmer mistakes.

Assertions are not a replacement for runtime validation.

---

# 20. Logging

Logging should support diagnostics without overwhelming developers.

Log messages should answer:

* What happened?
* Where?
* Why?
* What should be investigated?

Messages should be specific and actionable.

Avoid vague entries such as:

```text
Error occurred.
```

Prefer messages that identify the subsystem and context.

---

# 21. Testing Standards

Production code and automated tests should evolve together.

Every significant implementation should include:

* unit tests;
* integration tests where appropriate;
* regression tests when defects are corrected.

Untested functionality should be considered incomplete.

---

# 22. Performance Guidelines

Performance optimization should follow measurement.

Recommended workflow:

1. Implement correctly.
2. Validate behavior.
3. Benchmark.
4. Profile.
5. Optimize.
6. Benchmark again.

Avoid speculative optimization.

---

## Hot Paths

Special attention should be given to:

* ECS iteration;
* archetype migration;
* scheduler execution;
* query evaluation;
* serialization;
* snapshot generation.

These areas should remain measurable through benchmarks.

---

# 23. Refactoring Standards

Refactoring should improve maintainability without changing observable behavior.

Every refactoring should preserve:

* correctness;
* determinism;
* API behavior;
* benchmark expectations.

Large refactorings should be performed separately from feature development.

---

# 24. Dependency Rules

Module dependencies should remain acyclic.

Allowed dependency direction should follow the approved architecture.

Lower-level modules must never depend on higher-level modules.

Developers should avoid introducing hidden coupling between subsystems.

---

# 25. Code Quality Checklist

Before submitting code for review, contributors should verify:

* [ ] Architecture respected
* [ ] Naming consistent
* [ ] Formatting correct
* [ ] Documentation updated
* [ ] Public APIs documented
* [ ] Tests implemented
* [ ] No duplicated logic
* [ ] Error handling appropriate
* [ ] Benchmarks considered (if applicable)
* [ ] CI expected to pass

This checklist should be used as a self-review before opening a Pull Request.

---

# 26. Common Anti-Patterns

The following practices should be avoided.

### Hidden Side Effects

Functions should not unexpectedly modify unrelated state.

---

### Excessive Coupling

Subsystems should communicate only through approved interfaces.

---

### Large Functions

Long functions often indicate multiple responsibilities.

Refactor when necessary.

---

### Magic Numbers

Replace unnamed literals with meaningful constants.

---

### Duplicate Logic

Common behavior should be extracted into reusable components where appropriate.

---

### Premature Optimization

Optimization should always be guided by benchmarks and profiling.

---

# 27. Code Review Expectations

Reviewers should evaluate code according to these standards.

Review questions include:

* Is the implementation correct?
* Is the architecture respected?
* Is the code readable?
* Are names meaningful?
* Is documentation sufficient?
* Are tests adequate?
* Does the implementation remain deterministic?

Consistency should be valued over individual stylistic preferences.

---

# 28. Continuous Improvement

Coding standards should evolve carefully.

Updates should occur only when they clearly improve:

* readability;
* maintainability;
* consistency;
* engineering quality.

Frequent stylistic changes should be avoided.

---

# 29. Definition of Well-Written Code

Well-written code in the Survivors Lords ECS Framework is:

* correct;
* deterministic;
* maintainable;
* readable;
* well-tested;
* documented;
* modular;
* architecture-compliant.

Engineering quality should be evident from the implementation itself.

---

# 30. Final Statement

These Coding Standards establish the implementation conventions for the Survivors Lords ECS Framework.

Together with the Architecture documents, the Implementation Roadmap, the Development Guidelines, the Testing Strategy, the Release Process, and the Contribution Guidelines, they define a comprehensive engineering foundation for the project.

By consistently applying these standards, contributors help ensure that the framework remains reliable, understandable, performant, and maintainable throughout its long-term evolution.
