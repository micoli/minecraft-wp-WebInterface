<h2>Parcels list of "{$data.world}"</h2>
<ul>
{foreach from=$data.parcels item=parcel}
	<li><b><a href="./{$parcel.regionId}">{$parcel.regionId}</a></b>
		<ul>
			<li>surface : {$parcel.surface} block&#178;</li>
			<li>{if $parcel.owner}owner : {$parcel.owner}, {/if}{$parcel.buyStatus|lower|capitalize}</li>
			<li>price : {$parcel.price}</li>
		</ul>
		<img src="{$data.morg_wi_url_root}/localPlan/{$parcel.world}__{$parcel.regionId}.png">
	</li>
{/foreach}
</ul>