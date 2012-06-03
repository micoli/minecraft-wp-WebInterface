<ul>
{foreach from=$data.heroes item=hero key=name}
<li>
	<b>
		<a href="./player/{$name}/">
		<img style="width:32px;height:32px;" src="{$data.morg_wi_url_root}../plugins/minecraft-wp-WebInterface/skin2/images/skins/{$name}/head_front.png">
		{$name|lower|capitalize}</a>
	</b>&nbsp;
	<i>{$hero.class}</i>
</li>
{/foreach}
</ul>