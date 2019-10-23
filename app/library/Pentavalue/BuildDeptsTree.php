<?php

namespace Vokuro\Pentavalue;

class BuildDeptsTree
{
	protected $root_depts;
	public $tree;

	public function __construct($root_depts)
	{
		$this->root_depts = $root_depts;
		$this->tree = $this->buildTree($root_depts);
	}

	protected function buildTree()
	{
		$tree = [];

		foreach($this->root_depts as $dept)
		{
			$tree[$dept->Title] = [
			'id'       => $dept->ID,
			'children' => $this->getChildren($dept->ID)
			];
		}

		return $tree;
	}

	protected function getChildren($root_dept_id)
	{
		$children = [];

		$child_depts = \DataCmsDeptsRel::find([
			'conditions' => 'Parent_Depts_ID = :parent:',
			'columns'    => 'ID,Title',
			'bind' => [
				'parent' => $root_dept_id
			]
			]);

		foreach($child_depts as $child_dept)
		{
			$children[] = [
				'id'   => $child_dept->ID,
				'name' => $child_dept->Title
			];
		}

		return $children;
	}
}