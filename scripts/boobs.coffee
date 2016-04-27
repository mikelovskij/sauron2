# Description 
#   Everyone loves boobs
# Commands:
#   hubot boobs - Rest and enjoy
#   hubot boobes N - get N pairs of boobs

api_key   = process.env.HUBOT_TUMBLR_API_KEY

bigBlack = (msg) -> 
  count = 20

  msg.http("http://api.tumblr.com/v2/blog/blackcockpictures.tumblr.com/posts/photo")
  .query(api_key: api_key, limit: count)
  .get() (err, res, body) ->
    if err
      msg.send "Tumblr says: #{err}"
      return

    content = JSON.parse(body)

    if content.meta.status isnt 200
      msg.send "Tumblr says: #{content.meta.msg}"
      return

    posts = content.response.posts
    numb = Math.floor(Math.random()*count)
    post = posts[numb]
    for photo in post.photos
      msg.send photo.original_size.url

module.exports = (robot) ->

  robot.hear /boobs|tett|seno|t\*ette|t\*tte|te\*\*e/i, (msg) ->
    if Math.floor(Math.random() * 5) == 1
      number = Math.floor(Math.random() * 3000)
      msg.http("http://api.oboobs.ru/boobs/" + number + "/1/rank/")
      .get() (err, res, body) ->
        response = JSON.parse(body)
        msg.send "http://media.oboobs.ru/" + el.preview for el in response
    else if Math.floor(Math.random()*30) == 1
      bigBlack(msg)
    
    
  robot.respond /boobes( (\d+))?/i, (msg) ->
    number = Math.floor(Math.random() * 3000)
    ct = msg.match[2] || 3
    ct = 3 if ct > 10
    msg.http("http://api.oboobs.ru/boobs/" + number + "/" + ct + "/rank/")
      .get() (err, res, body) ->
        response = JSON.parse(body)
        msg.send "http://media.oboobs.ru/" + el.preview for el in response
        
  robot.respond /bbc/i, (msg) ->
    bigBlack(msg)
        

