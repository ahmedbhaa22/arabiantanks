<?php 
class CharityUsersInfo extends \Phalcon\Mvc\Model{
	public $id;
	public $user_id;
	public $phone;
	public $post_code;
	public $license;
	public $fax;
	public $charity_id;
	public $active;
	public $secret_code;
	
	 public function getSource()
    {
        return 'charity_users_info';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsDeptsRelItem[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return DataCmsDeptsRelItem
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }
	public function initialize()
    {
        $this->belongsTo(
            "user_id",
            'Models\UsersMobile',
            "ID",
            [
                'alias' => 'User',
                'reusable' => true
            ]
        );
		$this->belongsTo(
            "charity_id",
            'Models\Content',
            "ID",
            [
                'alias' => 'Content',
                'reusable' => true
            ]
        );
	}
}
