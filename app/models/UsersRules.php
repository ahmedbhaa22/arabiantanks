<?php  namespace Vokuro\Models;

class UsersRules extends \Phalcon\Mvc\Model {
    public $id;
    public $name;
    public $application_id;
    
    public function getSource() {
        return 'users_rules';
    }
    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return UsersRules[]
     */
    public static function find($parameters = null) {
        return parent::find($parameters);
    }
    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return UsersRules
     */
    public static function findFirst($parameters = null) {
        return parent::findFirst($parameters);
    }
    
    public function initialize() {
       $this->hasMany(
            "id",
            UsersUsersRules::class,
            "rule_id",
            [
                'alias' => 'RulesUser',
                'reusable' => true
            ]
        );
    }

}
