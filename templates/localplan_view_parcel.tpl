<h2>{$data.parcel.regionId} of "{$data.world}"</h2>
<ul>
	<li>surface : {$data.parcel.surface} block&#178;</li>
	<li>{if $data.parcel.owner}owner : {$data.parcel.owner}, {/if}{$data.parcel.buyStatus|lower|capitalize}</li>
	<li>price : {$data.parcel.price}</li>
</ul>
<img src="{$data.morg_wi_url_root}/localPlan/{$data.parcel.world}__{$data.parcel.regionId}.png">
