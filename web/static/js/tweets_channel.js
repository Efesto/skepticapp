import socket from "./socket";

let TweetsChannel = {
  init() {
    socket.connect();

    let container = document.getElementById("tweets_list");

    // Now that you are connected, you can join channels with a topic:
    let channel = socket.channel("tweets", {});
    channel
      .join()
      .receive("ok", resp => {
        console.log("Joined successfully", resp);
      })
      .receive("error", resp => {
        console.log("Unable to join", resp);
      });

    channel.on("new_tweets", ({ tweets, totalTweetsCount }) => {
      console.log(`${tweets.length} new tweets`);
      tweets.forEach(t => {
        this.renderTweet(container, t);
      });
      this.updateCount(totalTweetsCount);
    });
  },

  renderTweet(container, tweet) {
    let template = document.createElement("li");
    template.className = "tweet";
    template.innerHTML = `
      <div class="tweet__user-container">
        <img class="tweet__user-image" src="${
          tweet.user.profile_image_url_https
        }" />
        <strong>${tweet.user.name}</strong>
      </div>
      <div class="tweet__content">
        <p>${tweet.text}</p>
        <em class="tweet__date">${tweet.created_at}</em>
      </div>
    `;

    container.prepend(template);
  },

  updateCount(totalTweetsCount) {
    document.getElementById("tweets-count").textContent = totalTweetsCount;
  }
};

export default TweetsChannel;
