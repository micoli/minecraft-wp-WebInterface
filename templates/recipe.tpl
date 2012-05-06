{foreach from=$dataL item=dataI}
<br/>{$name}&nbsp;<img src="{$dataI.col_result}">
			
<table cellspacing="0" cellpadding="0" style="background: #C6C6C6; border: outset 2px #999; padding: 6px; width:230px;height:148px">
	<tbody>
		<tr>
			{include file="templates/recipe_cell.tpl" x=0 y=2}
			{include file="templates/recipe_cell.tpl" x=1 y=2}
			{include file="templates/recipe_cell.tpl" x=2 y=2}
			<td width="40" align="center" style="border: none; padding: 0" rowspan="3"><img width="32" height="27" src="{$datas.morg_wi_export_root}/../plugins/minecraft-WebInterface/image/Grid_layout_Arrow_(small).png" alt="">
			</td>
			<td style="border: none; padding: 0" rowspan="3">
				<div style="position: relative">
					<img width="52" height="52" src="{$datas.morg_wi_export_root}/../plugins/minecraft-WebInterface/image/Grid_layout_None_(small).png" alt="">
					<span class="grid-output"><a title="{$data.str_result|lower|capitalize}" href="/wiki/"><img width="32" height="32" src="{$dataI.col_result}" alt="{$data.str_result|lower|capitalize}"> </a> </span>
				</div>
			</td>
		</tr>
		<tr>
			{include file="templates/recipe_cell.tpl" x=0 y=1}
			{include file="templates/recipe_cell.tpl" x=1 y=1}
			{include file="templates/recipe_cell.tpl" x=2 y=1}
		</tr>
		<tr>
			{include file="templates/recipe_cell.tpl" x=0 y=0}
			{include file="templates/recipe_cell.tpl" x=1 y=0}
			{include file="templates/recipe_cell.tpl" x=2 y=0}
		</tr>
	</tbody>
</table>
{/foreach}