# Nami Writes

Nami's Blog.

It uses a starter repository from [Eleventy](https://www.11ty.dev/) site generator.

## How to run

1. Install dependencies

```bash
npm install
```

2. Run Eleventy

```bash
npx @11ty/eleventy --serve
```

## How to create a new post

Create a post for today:

```bash
npm run new-post "Post Title"
```

This creates `content/blog/YYYY-MM-DD/YYYY-MM-DD.md` with a randomly generated permalink, and opens the file in your `$EDITOR`.

To add a slug to the filename:

```bash
npm run new-post "Post Title" my-slug
```

This creates `content/blog/YYYY-MM-DD/YYYY-MM-DD-my-slug.md`.

To specify the date instead of today, pass it as the last argument:

```bash
npm run new-post "Post Title" 2023-01-06
npm run new-post "Post Title" my-slug 2023-01-06
```

## Contributors

- @nsunami (authoring, coding)
- @jazellemaira (copy editing, proofreading, coding)
