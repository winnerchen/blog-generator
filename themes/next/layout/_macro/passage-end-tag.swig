<div>
    {% if not is_index %}
        <div style="text-align:center;color: #ccc;font-size:14px;">-------------End of the post-------------</div>
		{% if page.copyright %}
<div class="my_post_copyright">
  <script src="//cdn.bootcss.com/clipboard.js/1.5.10/clipboard.min.js"></script>
  
  <!-- JS库 sweetalert 可修改路径 -->
  
  <p><span>Title:</span><a href="{{ url_for(page.path) }}">{{ page.title }}</a></p>
  <p><span>Author:</span><a href="/" title="Visit {{ theme.author }} personal blog">{{ theme.author }}</a></p>
  <p><span>Post time:</span>{{ page.date.format("YYYY-MM-DD - HH:MM") }}</p>
  <p><span>Last update:</span>{{ page.updated.format("YYYY-MM-DD - HH:MM") }}</p>
  <p><span>Link:</span><a href="{{ url_for(page.path) }}" title="{{ page.title }}">{{ page.permalink }}</a>
    <span class="copy-path"  title="click to copy the link"><i class="fa fa-clipboard" data-clipboard-text="{{ page.permalink }}"  aria-label="copy to clipboard！"></i></span>
  </p>
  <p><span>Agreement:</span><i class="fa fa-creative-commons"></i> <a rel="license" href="https://creativecommons.org/licenses/by-nc-nd/4.0/" target="_blank" title="Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)">Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)</a> Please retain the original link and author.</p>  
</div>
<script> 
    var clipboard = new Clipboard('.fa-clipboard');
    clipboard.on('success', $(function(){
      $(".fa-clipboard").click(function(){
        swal({   
          title: "",   
          text: 'copied',   
          html: false,
          timer: 500,   
          showConfirmButton: false
        });
      });
    }));  
</script>
{% endif %}
    {% endif %}
	
</div>