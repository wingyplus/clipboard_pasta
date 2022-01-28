use atoms::{error, ok};
use copypasta::{ClipboardContext, ClipboardProvider};
use rustler::{Encoder, Env, Term};

mod atoms {
    rustler::atoms! {
        ok,
        error
    }
}

#[rustler::nif]
fn copy<'a>(env: Env<'a>, content: String) -> Term<'a> {
    let mut ctx = ClipboardContext::new().unwrap();
    match ctx.set_contents(content) {
        Ok(_) => ok().encode(env),
        Err(_) => error().encode(env),
    }
}

#[rustler::nif]
fn paste<'a>(env: Env<'a>) -> Term<'a> {
    let mut ctx = ClipboardContext::new().unwrap();
    match ctx.get_contents() {
        Ok(content) => (ok(), content).encode(env),
        Err(_) => error().encode(env),
    }
}

rustler::init!("Elixir.Clipboard.NIF", [copy, paste]);
