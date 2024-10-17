## Search Container Reqs

### URL Request: 

General: 

```
https://newsapi.org/v2/everything?q=bitcoin&apiKey=f79971a0373d405c8de63ed005117b88
```



URL Response: 

```json
{
  "status": "ok",
  "totalResults": 7063,
  "articles": [
    {
      "source": {
        "id": "wired",
        "name": "Wired"
      },
      "author": "Joel Khalili",
      "title": "Unmasking Bitcoin Creator Satoshi Nakamoto—Again",
      "description": "A new HBO documentary takes a swing at uncovering the real identity of Satoshi Nakamoto, inventor of Bitcoin. But without incontrovertible proof, the myth lives on.",
      "url": "https://www.wired.com/story/unmasking-bitcoin-creator-satoshi-nakamoto-again/",
      "urlToImage": "https://media.wired.com/photos/6703eb3979f13fda7f04485b/191:100/w_1280,c_limit/Satoshi-Nakamoto-biz-1341874258.jpg",
      "publishedAt": "2024-10-09T01:00:00Z",
      "content": "Peter Todd is standing on the upper floor of a dilapidated industrial building somewhere in Czechia, chuckling under his breath. He has just been accused on camera of being Satoshi Nakamoto, the Bitc… [+3043 chars]"
    }
  ]
}
```



**Search Options:** 

- Open Ended Typed Search 

  - `title`

  - `description`

  - `content`

**Filter Options:**

- Sources
- Domains
- Exclude-Domains
- Date: From / To
- Language 



**Sort Options:** 

- `relevancy`
-  `popularity`
-  `publishedAt`

**General Params:** 

- `pageSize` - number of results per page. Max Results == 100
- `page` - current page