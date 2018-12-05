import TokenField from "tokenfield";
import "tokenfield/dist/tokenfield.css";
const tag_input = document.getElementById("post_tags");

if (tag_input !== null) {
  const input = new TokenField({
    el: tag_input
  });
}
