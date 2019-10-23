<?php

use Phalcon\Db\Column;
use Phalcon\Db\Index;
use Phalcon\Db\Reference;
use Phalcon\Mvc\Model\Migration;

/**
 * Class ContentMigration_100
 */
class ContentMigration_100 extends Migration {

    /**
     * Define the table structure
     *
     * @return void
     */
    public function morph() {
        $this->morphTable('content', [
            'columns' => [
                new Column(
                        'id', [
                    'type' => Column::TYPE_INTEGER,
                    'unsigned' => true,
                    'notNull' => true,
                    'autoIncrement' => true,
                    'size' => 11,
                    'first' => true
                        ]
                ),
                new Column(
                        'content_body', [
                    'type' => Column::TYPE_VARCHAR,
                    'notNull' => true,
                    'size' => 255,
                        ]
                ),
                new Column(
                        'content_description', [
                    'type' => Column::TYPE_VARCHAR,
                    'notNull' => true,
                    'size' => 255,
                        ]
                ),
                
                 new Column(
                        'content_picture', [
                    'type' => Column::TYPE_VARCHAR,
                    'notNull' => false,
                    'size' => 255,
                        ]
                ),
                new Column(
                        'content_created_at', [
                    'type' => Column::TYPE_TIMESTAMP,
                    'notNull' => true,
                        ]
                ),
            ],
            'indexes' => [
                new Index('PRIMARY', ['id'], 'PRIMARY')
            ],
            'options' => [
                'TABLE_TYPE' => 'BASE TABLE',
                'AUTO_INCREMENT' => '1',
                'ENGINE' => 'InnoDB',
                'TABLE_COLLATION' => 'latin1_swedish_ci'
            ],
                ]
        );
    }

    /**
     * Run the migrations
     *
     * @return void
     */
    public function up() {
        
    }

    /**
     * Reverse the migrations
     *
     * @return void
     */
    public function down() {
        
    }

}
