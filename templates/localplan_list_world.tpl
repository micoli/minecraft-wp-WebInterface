<h2>Worlds list</h2>
<ul>
{foreach from=$data.worlds key=world item=nb}
	<li><a href="./{$world}">{$world}</a> ({$nb} parcels)</li>
{/foreach}
</ul>