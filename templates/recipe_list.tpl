{literal}
<style>
	.minecraftItemBP{
		width:20px;
		height:20px;
		background-image:url({/literal}{$data.morg_wi_export_root}{literal}/items/__allicons.jpg);
	}
	.entry-content table, .comment-content table {
		border-bottom: 1px solid #DDDDDD;
		margin: 0 0 1.625em;
		width: 100%;
	}
	.grid-input {
		left: 2px;
		position: absolute;
		top: 2px;
		z-index: 1;
	}
	.grid-output {
		left: 10px;
		position: absolute;
		top: 10px;
		z-index: 1;
	}
	.tablerecipe {
		border-collapse: separate;
		border-spacing: 0;
	}
</style>
{/literal}

{foreach from=$datas.items key=name item=dataL}
	{if $dataL|@is_array}
		{include file="templates/recipe.tpl}
	{/if}
{/foreach}