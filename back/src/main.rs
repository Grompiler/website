use rust_embed::RustEmbed;
use salvo::prelude::*;
use salvo::serve_static::{static_embed, StaticDir};

#[derive(RustEmbed)]
#[folder = "./images"]
struct Assets;

#[tokio::main]
async fn main() {
    let router = Router::new()
        .push(
            Router::with_path("api")
                .push(Router::with_path("home").get(home))
                .push(Router::with_path("articles").get(articles))
                .push(Router::with_path("books").get(books))
                .push(Router::with_path("images/<**path>").get(static_embed::<Assets>())),
        )
        .push(
            Router::with_path("<**>").get(
                StaticDir::new(["../front/dist"])
                    .with_defaults(["./index.html"])
                    .with_fallback("./index.html"),
            ),
        );

    Server::new(TcpListener::bind("0.0.0.0:7878"))
        .serve(router)
        .await;
}

#[handler]
async fn home() -> &'static str {
    r#"
        # this is the home page \endline
        # this is the home page \endline
        # this is the home page \endline
        this is a page about something
        this is a page about something
        this is a page about something
        this is a page about something
        this is a page about something
        this is a page about something
        this is a page about something
        this is a page about something
        this is a page about something
        those are my articles from backend
        those are my articles from backend. \endline
    "#
}

#[handler]
async fn books() -> &'static str {
    r#"
        # then we have a h1 style \endline
        ## then we have 2 h2 styles \endline
        ## then we have 2 h2 styles \endline
        this page is about the books I read \endline
        this page is about the books I read
        this page is about the books I read
        this page is about the books I read \endline
        this page is about the books I read \endline
    "#
}

#[handler]
async fn articles() -> &'static str {
    r#"
        # then we have a h1 style \endline
        ## then we have 2 h2 styles \endline
        ## then we have 2 h2 styles \endline
        Those are my articles from backend those are my articles from backend \endline
        those are my articles from backend
        those are my articles from backend
        those are my articles from backend. \endline
        \image Screenshot api/images/screenshot.png \endline
        those are my articles from backend,
        those are my articles from backend,
        those are my articles from backend.
    "#
}

struct Publication {
    content: String,
}
