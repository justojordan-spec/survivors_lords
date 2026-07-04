# 17. CONTRIBUTING

---

# 1. Purpose

This document defines the official contribution process for the Survivors Lords ECS Framework.

Its purpose is to establish a consistent engineering workflow that allows multiple contributors to collaborate efficiently while preserving the framework's architecture, determinism, maintainability, and overall quality.

Every contribution—regardless of its size—should follow the process described in this document.

---

# 2. Scope

These guidelines apply to every repository belonging to the Survivors Lords Framework, including:

* Runtime
* ECS Core
* Scheduler
* Registry Systems
* Query Engine
* Event Bus
* Save System
* Multiplayer
* Tooling
* Documentation
* Examples
* Benchmarks
* Testing Infrastructure

The contribution process applies equally to:

* source code;
* documentation;
* tests;
* benchmarks;
* build scripts;
* development tools.

---

# 3. Contribution Philosophy

The framework is intended to evolve over many years.

Every contribution should improve one or more of the following:

* correctness;
* maintainability;
* readability;
* determinism;
* performance;
* documentation;
* testing.

Contributors should avoid changes that introduce unnecessary complexity or deviate from the approved architecture.

---

# 4. Core Principles

Every contribution should respect the following principles.

---

## 4.1 Architecture First

The approved architecture is the authoritative source of truth.

Implementation should conform to architecture.

Contributors must not redesign subsystems during implementation unless an architectural revision has been formally approved.

---

## 4.2 Quality Before Quantity

A small, well-tested contribution is preferable to a large, incomplete one.

Every change should be:

* understandable;
* reviewable;
* documented;
* tested.

---

## 4.3 Incremental Development

Large features should be divided into smaller contributions whenever practical.

Smaller changes provide:

* easier reviews;
* lower integration risk;
* simpler debugging;
* faster feedback.

---

## 4.4 Determinism Preservation

Contributors must ensure that changes do not introduce non-deterministic behavior.

Special attention should be given to:

* execution order;
* entity iteration;
* serialization;
* networking;
* scheduler behavior.

---

## 4.5 Documentation Is Mandatory

Documentation is part of every contribution.

New public functionality should include corresponding documentation before review is requested.

---

# 5. Types of Contributions

The framework accepts several categories of contributions.

---

## Feature

Introduces new functionality already approved by the roadmap or architecture.

Requirements:

* implementation;
* tests;
* documentation.

---

## Bug Fix

Corrects incorrect behavior.

Requirements:

* root cause identified;
* regression test added;
* documentation updated if necessary.

---

## Refactoring

Improves internal implementation without changing external behavior.

Requirements:

* full automated validation;
* no API changes unless explicitly approved;
* benchmark verification when performance-sensitive.

---

## Performance Improvement

Optimizes existing behavior.

Requirements:

* benchmark demonstrating improvement;
* correctness preserved;
* deterministic behavior unchanged.

---

## Documentation

Improves project documentation.

Examples include:

* API documentation;
* guides;
* tutorials;
* architecture clarifications;
* implementation notes.

Documentation-only changes should still undergo review.

---

## Testing

Improves automated validation.

Examples:

* new unit tests;
* regression tests;
* integration tests;
* benchmark additions;
* stress tests.

Testing improvements are encouraged independently of feature work.

---

# 6. Before Starting Work

Before implementing a contribution, contributors should verify:

* the architecture supports the proposed change;
* no existing work already addresses the same objective;
* the implementation roadmap includes the relevant phase;
* required dependencies have already been completed.

Beginning implementation before prerequisites are satisfied is discouraged.

---

# 7. Branching Workflow

Development should occur in dedicated branches.

Typical branch types include:

```text
feature/

bugfix/

refactor/

docs/

test/

benchmark/

hotfix/
```

Branch names should clearly describe their purpose.

Examples:

```text
feature/query-cache

bugfix/entity-generation

docs/testing-strategy

refactor/scheduler-validation
```

---

# 8. Contribution Workflow

Every contribution should follow the same lifecycle.

```text
Identify Work
        ↓
Create Branch
        ↓
Implement
        ↓
Write Tests
        ↓
Update Documentation
        ↓
Run Validation
        ↓
Open Pull Request
        ↓
Code Review
        ↓
Merge
```

Skipping workflow stages increases integration risk.

---

# 9. Implementation Expectations

Before requesting review, contributors should ensure that:

* implementation is complete;
* architecture has been respected;
* unnecessary complexity has been avoided;
* public APIs are justified;
* documentation has been updated;
* automated tests have been added.

Incomplete work should remain in development branches until ready for review.

---

# 10. Commit Guidelines

Commits should represent coherent units of work.

Each commit should address a single logical objective whenever practical.

Avoid commits that combine unrelated changes.

Examples of good commit scope:

* implement archetype migration;
* fix scheduler dependency validation;
* improve query cache documentation.

---

## Commit Messages

Commit messages should be concise and descriptive.

Recommended style:

```text
<type>: <summary>
```

Examples:

```text
feat: implement archetype transition cache

fix: prevent invalid entity reuse

docs: expand scheduler documentation

test: add regression coverage for query invalidation

refactor: simplify event queue validation
```

Commit history should communicate the evolution of the project clearly.

---

# 11. Pull Request Preparation

Before opening a Pull Request, contributors should verify that:

* the branch is synchronized with the integration branch;
* merge conflicts are resolved;
* CI passes locally where possible;
* documentation reflects the implementation;
* tests pass successfully.

Only review-ready contributions should be submitted.

---

# 12. Pull Request Content

Each Pull Request should include:

## Summary

A concise explanation of the change.

---

## Motivation

Why the change is necessary.

---

## Scope

Affected subsystems.

Examples:

* ECS
* Scheduler
* Query Engine
* Save System

---

## Testing

Describe the validation performed.

Examples:

* unit tests;
* integration tests;
* benchmarks;
* regression tests.

---

## Documentation

Identify documentation updated as part of the contribution.

Reviewers should be able to understand the complete impact of the change from the Pull Request description alone.

---

# 13. Pull Request Size

Smaller Pull Requests are strongly preferred.

As a general guideline:

* one feature per Pull Request;
* one bug fix per Pull Request;
* one refactoring objective per Pull Request.

Large Pull Requests increase review complexity and integration risk.

When a feature is substantial, it should be divided into multiple incremental contributions whenever possible.

# 14. Code Review Process

Every Pull Request must undergo code review before it can be merged.

Code review is one of the primary mechanisms used to preserve the long-term quality of the framework.

The objective of a review is not only to identify defects, but also to ensure that every contribution remains consistent with the project's engineering standards.

---

## 14.1 Review Goals

A review should verify:

* architectural compliance;
* implementation correctness;
* deterministic behavior;
* readability;
* maintainability;
* API consistency;
* testing completeness;
* documentation quality.

Reviews should focus on the implementation itself rather than personal coding preferences.

---

## 14.2 Reviewer Responsibilities

Reviewers should:

* understand the affected subsystem;
* verify compliance with the architecture;
* execute or inspect validation results when necessary;
* request clarification whenever implementation intent is unclear;
* provide constructive, actionable feedback.

Whenever possible, feedback should explain both the identified issue and the reason behind the recommendation.

---

## 14.3 Contributor Responsibilities

Contributors are expected to:

* respond to review comments professionally;
* explain implementation decisions when requested;
* update documentation if required;
* modify the implementation when legitimate issues are identified;
* rerun validation after making review changes.

Review discussion should remain focused on improving the framework.

---

## 14.4 Approval Criteria

A Pull Request should only be approved when:

* implementation is complete;
* required tests pass;
* documentation has been updated;
* architecture has been respected;
* review feedback has been addressed;
* CI is successful.

Approval should indicate confidence that the contribution is ready for integration.

---

# 15. Merge Policy

Merging into the primary integration branch should occur only after all required conditions have been satisfied.

The following conditions are mandatory:

* approved review;
* successful CI;
* resolved discussions;
* up-to-date branch;
* no unresolved merge conflicts.

Direct commits to protected branches should be avoided.

---

## 15.1 Merge Strategy

The project should use a consistent merge strategy throughout its lifetime.

Regardless of the chosen strategy, the resulting history should remain:

* understandable;
* traceable;
* reproducible.

History should clearly communicate the evolution of the framework.

---

# 16. Handling Conflicts

Merge conflicts should be resolved by the contributor whenever practical.

After resolving conflicts:

* rebuild the project;
* rerun affected tests;
* verify documentation;
* confirm CI passes.

Conflict resolution should never introduce unrelated changes.

---

# 17. Issue Tracking

Every significant development task should be traceable.

Issues should contain:

* objective;
* description;
* affected subsystem;
* priority;
* acceptance criteria.

Whenever applicable, implementation work should reference its corresponding issue.

---

## Issue Categories

Recommended categories include:

* Feature
* Bug
* Regression
* Performance
* Documentation
* Refactoring
* Testing
* Maintenance

Using consistent issue categories improves project planning and reporting.

---

# 18. Feature Requests

Feature requests should be evaluated before implementation begins.

Evaluation should consider:

* architectural compatibility;
* implementation complexity;
* long-term maintenance cost;
* interaction with existing systems;
* roadmap alignment.

Not every proposed feature should necessarily be accepted.

---

# 19. Bug Reports

A useful bug report should include:

* affected subsystem;
* observed behavior;
* expected behavior;
* reproduction steps;
* relevant logs;
* framework version.

If possible, a minimal reproducible example should accompany the report.

---

# 20. Regression Management

When a regression is identified:

1. confirm the regression;
2. identify the responsible change;
3. create a regression test;
4. implement the correction;
5. validate the complete affected subsystem.

Regression testing should permanently protect against recurrence.

---

# 21. Documentation Contributions

Documentation contributions follow the same review process as source code.

Documentation should be:

* technically accurate;
* internally consistent;
* synchronized with implementation;
* written using project terminology.

Outdated documentation should be corrected promptly.

---

# 22. Testing Contributions

Testing improvements are valuable contributions even when no production code changes occur.

Examples include:

* additional unit tests;
* improved integration scenarios;
* expanded stress testing;
* benchmark improvements;
* regression coverage.

Testing contributions should preserve readability and determinism.

---

# 23. Performance Contributions

Performance improvements should always include measurable evidence.

Contributors should provide:

* benchmark methodology;
* baseline measurements;
* optimized measurements;
* explanation of observed improvements.

Optimizations without measurable benefit should generally be avoided.

---

# 24. Security and Reliability

Although the framework is primarily an internal engine component, contributors should prioritize robust and defensive implementation.

Changes should avoid introducing:

* undefined behavior;
* unsafe memory access;
* invalid state transitions;
* inconsistent serialization;
* nondeterministic execution.

Reliability should take precedence over implementation shortcuts.

---

# 25. Definition of a Ready Contribution

A contribution is considered ready for review when:

* implementation is complete;
* documentation is updated;
* tests have been added or updated;
* formatting rules are satisfied;
* static analysis passes;
* CI is expected to succeed.

Work-in-progress contributions should be clearly identified as such.

---

# 26. Definition of an Accepted Contribution

A contribution is considered accepted only after:

* code review approval;
* successful CI;
* merge into the integration branch;
* associated documentation updates;
* completion of all requested review changes.

Acceptance represents successful integration into the framework.

---

# 27. Contributor Code of Conduct

Technical discussions should remain:

* respectful;
* constructive;
* evidence-based;
* focused on the project.

Disagreements should be resolved through technical reasoning, architectural documentation, benchmarks, or additional testing.

Personal criticism has no place in engineering reviews.

---

# 28. Long-Term Collaboration

The Survivors Lords ECS Framework is intended to be maintained for many years.

Long-term collaboration requires:

* consistent engineering practices;
* predictable workflows;
* comprehensive documentation;
* shared ownership of quality;
* continuous improvement.

Every contribution should leave the framework in a better state than before.

---

# 29. Definition of Success

The contribution process is successful when it consistently produces:

* maintainable implementations;
* deterministic behavior;
* stable APIs;
* comprehensive automated testing;
* accurate documentation;
* predictable releases.

Engineering discipline should scale with the framework as it grows.

---

# 30. Final Statement

This document defines the official contribution workflow for the Survivors Lords ECS Framework.

Together with the Architecture documents, the Implementation Roadmap, the Development Guidelines, the Testing Strategy, and the Release Process, it establishes a complete engineering lifecycle for collaborative development.

By following these contribution guidelines, the framework can continue to evolve through well-reviewed, well-tested, and well-documented changes while preserving the architectural integrity and engineering standards established by the project.
