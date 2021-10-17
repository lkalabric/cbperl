use Bio::DB::GenBank;

$db_obj = Bio::DB::GenBank->new; 
$seq_obj = $db_obj->get_Seq_by_acc("J01673");