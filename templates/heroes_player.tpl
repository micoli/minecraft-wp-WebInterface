<script type="text/javascript" src="{$data.morg_wi_url_root}../plugins/minecraft-wp-WebInterface/skin2/backend/resources/3d/Three.js"></script>
<script type="text/javascript" src="{$data.morg_wi_url_root}../plugins/minecraft-wp-WebInterface/skin2/backend/resources/3d/RequestAnimationFrame.js"></script>
<script type="text/javascript" src="{$data.morg_wi_url_root}../plugins/minecraft-wp-WebInterface/skin2/backend/resources/3d/mineCraftPlayer.js"></script>
{literal}
<script type="text/javascript">
	$(document).ready(function (){
		$('.mineCraftPlayer').each(function(k,ele){
			mineCraftPlayer($(ele).attr('title'),ele,'{/literal}{$data.morg_wi_url_root}{literal}../plugins/minecraft-wp-WebInterface/skin2/images/skins/');
		});
	});
</script>
{/literal}
<div>
	<span style="float:left;">
		<h1>{$data.hero.name|lower|capitalize}</h1>
		<h2><i>{$data.hero.class}</i></h2>
		<ul>
			<li>Health : {$data.hero.health}</li>
			<li>Mana : {$data.hero.mana}</li>
		</ul>
	</span>
	<span id="divRenderer" class="mineCraftPlayer" title="{$data.hero.imgName}" style="float:right;height:200px;width:200px;">
	</span>
</div>
