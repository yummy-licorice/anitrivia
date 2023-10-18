import std/options

type
  Anime* = object
    name*: string
    img*: string
    color*: string
  Title* = object
    english*: Option[string]
  CoverImage* = object
    large*: string
    color*: string
  Media* = object
    title*: Title
    coverImage*: CoverImage
    isAdult*: bool
  Data* = object
    Media*: Media
  JSON* = object
    data*: Data
