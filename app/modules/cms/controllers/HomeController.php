<?php

namespace Vokuro\Cms\Controllers;

use Models\DataCmsSavedFilter;
use Models\EntityTags;
use Phalcon\Mvc\Model\Resultset\Simple;
use Vokuro\Controllers\ControllerBase;

use Models\Content;
use Models\DataCmsFilterSearch;
use Phalcon\Http\Request;
use Phalcon\Paginator\Adapter\Model as Paginator;
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Security;
use Phalcon\Security\Random;
use Phalcon\Mvc\Url;
use Vokuro\Forms\AdvancedSearchForm;
use Vokuro\Models\ProductExtraFields;
use Vokuro\Models\Tags;
use Vokuro\Models\TanksSideMenu;
use Vokuro\Pentavalue\Keyvalue;
use Phalcon\Mvc\Model\Query\Builder;
use DataTables\DataTable;
use \DataKeyvalueGroup;
use \DataKeyvalueGroupLang;
use \DataCmsLang;

use Models\GoappDataCmsZones;
use Vokuro\Geo\Models\GeoRegions;
use Vokuro\Geo\Models\GeoRegionsLang;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Vokuro\Pentavalue\BuildDeptsTree;
use Vokuro\Discounts\Models\Discounts;
use Vokuro\Discounts\Models\DiscountRelItems;
use Vokuro\Pentavalue\RequestValidation;
use Vokuro\Maintenance\Models\TicketProblemsStatus;

class HomeController extends ControllerBase{
    public function indexAction($parent_id){
        $parent_id = (int)$parent_id;
        $items = TanksSideMenu::find(["parent_id={$parent_id} and active =1"]);
        $this->view->content = $items->toArray();
    }
}
