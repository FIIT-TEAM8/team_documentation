Frontend routes are defined in the core `App.jsx` component using the [react-router@6](https://reactrouter.com/docs/en/v6/getting-started/overview).

Components:
----
`<Route/>` used for defining routes (can be nested)

`<Navigate/>` used for redirection on render

`<Link/>` used as an `<a/>` tag

Hooks:
----
`useNavigate()` used for redirection in a functional manner

Routes:
====
| Endpoint | Component | Note |
| -------- | --------- | ---- |
| _/_ | `<Navigate/>` | Redirects to _/**search**_ |
| _/**search**_ | `<TitleSearch/>` | |
| _/search/**results**_ | `<SearchResults/>` | |
| _/**example**_ | `<div/>` | Example of a new route |
