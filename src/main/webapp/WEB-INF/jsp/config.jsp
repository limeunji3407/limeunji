<%@page contentType="text/html; charset=euc-kr"%>
<% 

//�Ŵ���ٿ�ε�(�⺻ true) ��ư ���� true = ��ư���̱� / false = ��ư�����
//2010�� 06�� 03�� �ڵ���
//boolean manualconf = true;

//������ ������������ ����������� ���� 
//2010�� 06�� 03�� �ڵ���
//�α��ν� ���������� ���� true = ��������� / false = ��������������
//û�۱�û(true) , ����û(false)
boolean startPage = true;

//��� Ȩ�������ΰ��� ��ư ���� true = ��������� / false = ��������������
//û�۱�û(true) , ����û(false)
boolean startHomePage = true;

//�����Ŵ� ���ѿ� ���� �����ֱ⼳�� true = ���ѿ����� �Ŵ������� / false = �����Ŵ���κ���
//2010�� 06�� 07�� �ڵ���
//û�۱�û(true) , ����û(false)
boolean leftMenuActive = true; 

//��� �������� �ڵ��� ����Ʈ�ڽ��� 013��ȣ�� ǥ�� true = ǥ�� / false = ��ǥ��
//2010�� 06�� 07�� �ڵ���
//û�۱�û(false) , ����û(true)
//boolean hpno013View = false;

//�޼����߼�ȭ�� > �ּҷϺ��� > �μ��� ������ true = ǥ�� / false = ��ǥ��
//2010�� 06�� 07�� �ڵ���
//û�۱�û(true) , ����û(false)
boolean departActive = true;

//�޼����߼�ȭ�� �̸������ư ��Ȱ��ȭ true = ǥ�� / false = ��ǥ��
//2010�� 06�� 07�� �ڵ���
//û�۱�û(true) , ����û(false) 
boolean previewActive = true;

//�����Ÿ�� Ȱ��ȭ true = ǥ�� / false = ��ǥ��
//���۰����� > ����ڰ��� > �߰���ɼ���:����ϼ��� true = ǥ�� / false = ��ǥ��
//2010�� 06�� 14�� �ڵ���
//û�۱�û(true) , ����û(false)
boolean mobileActive = false;

//�����Ÿ�� �ּ� ����
//2010�� 06�� 14�� �ڵ���
String mobileAddress = "http://123.123.123.123:9090/member/Login?id=";

//û�۱�û:: Ÿ��Ʋ ���� 
//2010�� 06�� 10�� ������
//String titleName = "++����ϸ޽�¡���� I-GOV++"; // ����Ʈ
//û�۱�û = "û�۱� ���չο��˸��̽ý���";
//����û = "���� ���չο��˸��̽ý���";
//String titleName = "SMS/MMS ���չο��˸��̽ý���";


//�޼������� ��ư Ȱ��ȭ true = ǥ�� / false = ��ǥ��
//2010�� 06�� 24�� �ڵ���
//û�۱�û(false) , ����û(true) 
boolean msgDelete = false;

//������� ��ư Ȱ��ȭ (�̹� �߼۵� ����׷츸) true = ǥ�� / false = ��ǥ��
//2016�� 12�� 26�� �����
boolean msgReservDelete = true;

//��� �Ŵ��ٿ� ��κ��� Ȱ��ȭ true = ǥ�� / false = ��ǥ��
//2010�� 06�� 24�� �ڵ���
//û�۱�û(false)
boolean nowURLView = false;

//�����>�ּҷϰ���> ��� �̹��� ��������
//true = �μ������� ����Ұ��(�μ��� �����)
//false = �μ������� ������� �������(�μ��� ������)
//2010�� 07�� 02�� �ڵ���
//û�۱�û(true) , ����û(false) 
boolean addressText = true;

//����� > �߼�ȭ�� > �ּҷϺ��� �� ��������
//true = �μ� -> �μ����� ���� -> ��ü���� �� ����
//false = �μ�, ���� 
//2010�� 07�� 02�� �ڵ���
//û�۱�û(true) , ����û(false) 
boolean addrTab = false;

//����� > ���۳�����ȸ > �˻���¥ �������� ( ������� 1�� ~ ������ )
//true = ������� 1�� ~ ������
//false = 7���� ~ ������
//2010�� 07�� 05�� �ڵ���
//û�۱�û(true) , ����û(false)
boolean searchDate  = true;

//�ּҷϿ� �׷��� �Ѱ��� ������� �ڵ�����  true = ���� / false = �����
//2010�� 7�� 6�� �ڵ���
//û�۱�û(true) , ����û(false)
//boolean defaultGroup = true;

//û�۱�û �ؽ�Ʈ�ڽ� �� ��ü ���� ������ Ȥ�� ���ϰ� ���� ��û  true = û�� ���ϰ� / false = ������
//2010�� 7�� 7�� �ڵ���
//û�۱�û(true) , �ٸ��� ���(false)
boolean cssCJ = true;

//������ȣ�� ������� �ڵ����� �Է��� �ݴϴ�.  true = �Է� / false = ���Է�
//2010�� 7�� 8�� �ڵ���
//û�۱�û(true)
//boolean areaCodeActive = true;

//�����»�� ��ȭ��ȣ�� ������ȣ�� ������� �̰��� ������ ��ȣ�� �ڵ����� �־��ݴϴ�.  
//2010�� 7�� 8�� �ڵ���
//û�۱�û 054
//String areaCode = "02";

//�����»�� ��ȭ��ȣ�� �ڵ���,�繫�� ��ȣ�� �����Ҽ� �ִ� �����ڽ��� ������ �ݴϴ�. true = ���� / false = �����
//2010�� 7�� 8�� �ڵ���
//û�۱�û(true) , ����û(false)
//boolean fromNumCheck = true;

//������>��������>������ҹ�ư�� ���̱� �Ⱥ��̱�  true = ���� / false = �Ⱥ���
//2010�� 7�� 14�� �ڵ���
//����Ʈ ���� false (������ �븮���� �����ڴ� ���� �ȵǰ� ���ڰ� �Ͻ�)
boolean reserCansleActive = false;

//�����>��Ƽ�߼�>�̹�������â �ϴ� ��ҹ�ư Ŭ����  true = �˾�â ���� / false = �˾�â ��ε���
//2010�� 8�� 10�� �ڵ���
//����Ʈ ���� false 
//û�۱�û true
boolean closeEditor = true;

//����� �ּҷ��� �ڵ��� �Է¶� 3ĭ -> ��ĭ���� �ٲٱ� true = ��ĭ / false = 3ĭ
//2010�� 8�� 11�� �ڵ���
//����Ʈ ���� false 
//û�۱�û true
//boolean hpnoForm = true;

//�ּҷϺ��� �� �� Ŭ���� �ϴ� ���ñ׷� �󼼺��� �� ������ ��ü�����ֱ� true = Ŭ���� �󼼱׷�  ������ ��ü�����ֱ�  / false = �󼼺��� �����ϱ�
//2010�� 8�� 19�� �ڵ���
//����Ʈ ���� false 
//û�۱�û true , ����û(false)
//boolean addressTabAll = true;

//���۰����� ������ ������� ��¥ ���� ( 12���� ������  ~ ������ )
//true = 12���� ������  ~ ������
//2010�� 10�� 06�� �ڵ���  -> ������ 2012.04.30  LEE
//û�۱�û(true) , ����û(false)
boolean searchDateMon12 = true;

//������踦 ��ġ�⵵�� ���� �˻� ����
//2010�� 10�� 06�� �ڵ���
//û�۱�û(true) , ����û(false)
boolean statYearActive = true;
//��ġ�⵵����
String statYearRdate = "2018";


//�������� ��ü������ȸ->�޽������� ����Ʈ:�����ٿ�ε忡 �̸�,�μ��׸�ǥ�ÿ���  true = �޴����������� �̸� ǥ��, false = �̸��׸� ����.
//2011�� 03�� 07�� �̸���
boolean statAddName = false;

//�������� �����ٿ�ε忡�� ��Ÿ���� ���ڷ� ������ �׸��� ����Header�� ����Ʈ
//2011�� 03�� 10�� �̸���
// ���� �߰� - ��: "�Ǽ�" ���� ���� (2018.11.07 KKW)
String[] arrNumTitle = {"�ѹ߼�","����","����","��ȣ����","����","������","���","����ĳ��","�Ǽ�","�����Ǽ�","�����ĳ��","�ӽ��߰��Ǽ�","�ӽ��߰�ĳ��"};

//�������� �۽����� �Ǽ�(�ܹ�, �幮, URL, MMS, ���� ��� ���� ����)
//2011��04��04�� �̸���
//�ɼ� �̻��(properties EXCELMEMBERLOADMAXCNT �ɼ����� ����)���� �ּ�ó�� 20130708 KKW 
//int sendLimit = 1000;

//������ ĳ��������û �˾�â  true: ǥ��, false: ��ǥ�� (cashCharge��� ����ڸ� �ݵ�� ����� ��� ���ڰ� ���� ��й�ȣ�� ��� ����)
//2011��05��11�� �̸���
boolean cashChargeActive = false;
//2011��05��18�� �̸��� �����������Ը� ǥ�� true: ���������� ǥ�� , false: ������� ǥ�� 
// ���� : (cashChargeActive:true) �϶��� �ش��
boolean cashChargeActiveForSaeallUser = false;

//2012��01��05�� �̸��� �Ϲݾ�ü(���)�� ȭ���� ���  true: �Ϲݾ�ü�� ȭ����(������ ����) , false: �ñ�����.  
//����ڰ���: [�ΰ������ڼ���],[�ֹε�ϰ����ڼ���] 2���޴�����
//�ý��۰���: [�߼۶��ΰ���],[�����ΰ���] 2���޴� ����
//������> ����� ��Ͻÿ� [�����ּҷϵ��] �׸� ����  
boolean useForCompany = false;

//2012��02��08�� �̸��� �μ���ȭ�� �޴� ����Ʈ���� [�μ������] ����Ʈ ǥ�ÿ���  true: ǥ����. false: ǥ�þ���. 
boolean regWorkerOfDept = true;

//2012��02��14�� �̸��� ����ȭ�� �޴� ����Ʈ���� [��������] ǥ�ÿ���  true: ǥ����. false: ǥ�þ���. 
boolean dispVMS = false;

//2012��02��21�� �̸��� ���ȭ�鿡�� �Ѱ��� ǥ�ÿ���  true: ǥ����. false: ǥ�þ���.  ���ֽ�û: true 
boolean dispTotPrice = true; 

//2012��02��21�� �̸��� �α���ȭ�鿡 ȸ������ ��ư ǥ�ÿ���  true: ǥ����. false: ǥ�þ���.  ���ֽ�û: true
boolean dispMemberJoin = true;

//2012��02��23�� �̸��� ������ ȭ���� ���� �Ŵ��� �ٿ�ε� �ؿ� �߼۱ݾװ�� ��ư ǥ�� ���� true: ǥ����. false: ǥ�þ���.  ���ֽ�û: true
boolean dispSendCalculator = false; 

//2012��02��23�� �̸��� �Ϲݻ���ڿ��� �α������� ǥ�ö��� ���� ���� Ÿ�Ժ�  �������۰��ɰǼ� ǥ�ÿ���  true: ǥ����. false: ǥ�þ���.  ���ֽ�û: true
//  (���� �߼۰��� �Ǽ�)
boolean dispPossibleSendCnt = true; 

//2012��02��23�� �̸��� �Ϲݻ���ڿ��� footer���� ��������ó����ħ ��ư  ǥ�ÿ���  true: ǥ����. false: ǥ�þ���.  ���ֽ�û: true
boolean dispPersonalInfoMang = false; 

//���۰����� ������ ������� ��¥ ���� ( ����⵵1��  ~ ������ )
// 1: 12���� ������  ~ ������  2: ���� ����  3:����⵵ 1�� ~ ������  
// 2012�� 4�� 30�� �̸���
//û�۱�û(1) , ����û(2)
int iDateMon12 = 3;

//2012��05��25�� �̸���  ������ ����ȭ��  true: ǥ��,  false:��ǥ��   ���ֽ�û: true 
boolean dispVideo = false; // ��� ���� - ���ε� ȭ�� �̱��� (2018.10.22)

//2012��6��22�� �̸���  ���ֽ�û ��ȣȭ �۾����ؼ� true: ���ֽ�û��   false: ���ֽ�û�� �ƴ�. 
boolean isGwangju = false;

//2012��6��22�� �̸���  ���ֽ�û ��ȣȭ �۾� ��ȣȭ dsd Ű����  
String sDsdCode = "sdjkfljaslkfsjadklf";

//2012��6��22�� �̸���  ���ֽ�û ��ȣȭ �۾� ��ȣȭ FSD Ȩ���丮 
String sFsdinitDir = "/usr/local/fsdinit";//����: ���� /�� �Ⱥ���

//2012��8��13��  �̸��� �н����� ������ ����.  
//String[] pwdForbiddenWord = {"love","happy","qwer","zxcv"};

//2012��8��14�� �̸��� �����ֱ� �н����� ���� �ֱ� (����: ��)  
int iPwChangeCycle_Mnt = 3;

//2012��8��20�� �̸��� �н����� ������ üũ ����  (true: ������ üũ , false: ������ üũ ����.)  
//boolean usePwForbWord = true;

//2012��8��20�� �̸��� ��밡�� ����ī��Ʈ�� 
// ���� 0�̸� ���� Ƚ�� ���� ���� (20131113 KKW)
// ���ǻ��� : igov.properties ���� ����ī��Ʈ�� ���� �����ؾ��� (20140214 KKW)
//int iUsableFailCnt = 5;

//2012��8��20�� �̸��� ���� �н����带 ����� �����Ͽ� �����н����� ���� üũ ����
// ���� 0�̸� ���� �н����带 ���Ѿ��� ��� (20131113 KKW)
//int iUsablePastPwCnt = 3;

//2012��9��14�� �̸��� �׼��� �α��� ��� ����. (����: ���� ������ (�� C:\\) ���� ��.) 
//String sAccesslogPath = "C:\\";
// kkk
//String sAccesslogPath = "/usr/local/tomcat7/acc_log/";
String sAccesslogPath = "D:\\imsi\\";

//2012��10��16 �̸��� ����� [�ΰ�����][�ֹε��]�޴��� [��û�ڰ���]�޴� ǥ������ true: ǥ�� false:��ǥ�� 
boolean applyMangFlg = false;


//2012��10��26 �̸��� ������ �� ����� ��������ÿ� �н����� �ʱ�ȭ�� �ʿ��� �н���������  
String sDefaultPW = "default123!";

//2012��12��06 �̸���  ����Ʈ�޴��� �α��� ����� �������� ����������ư�� ǥ������ 
Boolean modifyIconFlg = true; 

//2013��1��11 �̸���  SSL�������(true: SSL ���,  false: SSL ������)   
//Boolean sslFlg = false;

//����Ʈ ȯ�漳�� DB  true: ���, false: �̻��  (2013.04.01 KKW)
//true �̸� TBCONFIG DB������ ���ǰ� ������ �н����弳������ �޴��� ǥ�� / false ���� �� config.jsp �� ������ ����˴ϴ�.
//*** ������ : �н���������, �н����庯���ֱ� *** 
boolean g_bConfigDbSetting = true;

//�н����� ���� (sPasswordPattern ���� bPasswordDbSetting �� false �϶��� �����)
// 08A:����,����,Ư������  8�ڸ� / 10A:����,���� 10�ڸ� / 10B:����,Ư������ 10�ڸ�
// 09A:����,����,Ư������ 9�ڸ�
//String g_sPasswordPattern = "09A";

//���ӱ����ȸ (�ý��۰���-���ӱ����ȸ) ǥ�ÿ���   true: ǥ��, false: ��ǥ��  (2013.03.28 KKW)
boolean g_bAccessHistory = true;

//�α��� ���� �� �н����� ���� Ƚ�� ǥ�ÿ���  true:ǥ��, false:��ǥ�� (2013.04.05 KKW)
//boolean g_PasswordFailCountDisplay = true;

// ����ȭ�� �޴� ����Ʈ���� [�ݹ�����] ǥ�ÿ���  true: ǥ����. false: ǥ�þ���. (20130626 KKW)
boolean g_dispURL = false;

// �α��� ���� �� DB���г��� �ʱ�ȭ ���� ����  true:�ʱ�ȭ, false:�ʱ�ȭ���� (false �� �α��� �����ص� �ʱ�ȭ ���� �ʰ� ��� ī��Ʈ��)  (20130703 KKW)
// ���ǻ��� : igov.properties ���� ����ī��Ʈ�� ���� �����ؾ��� (20140217 KKW)
//boolean g_bLoginFailinit = true;

// �糭�����μ��ڵ� : �������� �ּҷ����� "�μ�����" ��Ī�� "�糭����" �� ǥ���ϱ� ����
// �ڵ尪�� ������ �ش� ���� �α��� �� "�糭����" ǥ��, �����̸� ��������� ���� "�μ�����"�� ǥ���� (20130805 KKW)
String g_sendAddrDeptTabDisp = "0000001";

// ������û ���� �̹��� ��� ����   true:ǥ��, false:��ǥ�� (20130902 KKW)
boolean g_yeongdongImgDisplay = true;

// �ΰ�������, �ֹΰ����� �޴� ǥ�� �ɼ� - useForCompany�ɼǰ� �޸� �� �ΰ� �޴� ǥ�ø� ����
// true:ǥ��, false:��ǥ�� (20131113 KKW)
boolean g_bDisplayInkamJuminMenu = false;

// �н����� �Է� �� ��������(ID���缺,���ӹ��� ��) üũ ��� �ɼ�    true:��������üũ����, false:üũ�� (20131113 KKW)
//boolean g_bPwFormCheckSkip = false;

// ����� ĳ�� ���� �� �μ� ĳ���� �ܿ� �ѵ� �̳������� �����ϰ� �� ������ �����ϴ� �ɼ�
// A:�μ��ܿ��ѵ�üũ��(�μ��ѵ�-������ѵ��� �պ��� Ŭ������), B:�μ��ѵ���üũ��(�μ��ѵ����� Ŭ������), C:�ѵ�üũ���� (20131218 KKW)
//String g_UserCashLimitCheckFlag = "A";

// ����� ĳ�� ���� �� �μ� ĳ���� �ܿ� �ѵ��� üũ�� �� �����ڰ� �Է��� �ӽ��߰�ĳ���� üũ�ϵ��� �� �������� �����ϴ� �ɼ�. (20140807 ������)
// g_UserCashLimitCheckFlag �� �Բ� ���ȴ�.
// g_UserCashLimitCheckFlag : A, g_addcashLimitCheckFlag : true => �μ��� �ܿ� �ѵ�(�ش� ������� ��ĳ���ѵ� + �ӽ��߰�ĳ�� ������)�� ������� �����Ϸ��� �� ĳ���ѵ� + �ӽ��߰�ĳ�� ��
// g_UserCashLimitCheckFlag : A, g_addcashLimitCheckFlag : false => �μ��� �ܿ� �ѵ�(�ش� ������� ��ĳ���ѵ� + �ӽ��߰�ĳ�� ������)�� ������� �����Ϸ��� �� ĳ���ѵ�  ��
// g_UserCashLimitCheckFlag : B, g_addcashLimitCheckFlag : true => �μ��� �ܿ� �ѵ�(�ش� ������� ��ĳ���ѵ� + �ӽ��߰�ĳ�� ����)�� ������� �����Ϸ��� �� ĳ���ѵ� + �ӽ��߰�ĳ�� ��
// g_UserCashLimitCheckFlag : B, g_addcashLimitCheckFlag : false => �μ��� �ܿ� �ѵ�(�ش� ������� ��ĳ���ѵ� + �ӽ��߰�ĳ�� ����)�� ������� �����Ϸ��� �� ĳ���ѵ� ��
//boolean g_addcashLimitCheckFlag = true;

// �Ϲݻ���� �ּҷϰ����� �μ����� ����� on/off �� �� �ִ� �ɼ� �߰�  (true:�μ����� ��� ���, false:�μ����� ��� �̻��) (20131231 KKW)
// �μ����� �μ��ּҷ��� ������ �� ������ �Ϲݻ���ڴ� ����ȭ�鿡�� �μ������ǵ� ����.
// �� ���� false �̸� �Ϲݻ������ �ּҷϰ��� ȭ�鿡�� �μ����� ��ư�� ��Ÿ���� ������ �μ����� �μ��ּҷ� ȭ�鿡�� ��������� �Ӹ� ����� ����
// �� ���� false �̸� �μ������� �������Ƿ� addressText ���� ���� ���� false �� �ٲܰ�
// ���� : ���� departActive �������� �Ϲ� ����ڿ� �μ��� ��� �μ��ּҷ��� �����ϰų� ��ȸ���� ���ϸ� ����ȭ�鿡�� �μ������ǵ� ������.
//boolean g_bDeptShare = true;

// �μ� ���� ���� ����  (20140107 KKW)
// (true �϶����� DEPT_RANK �÷��� ����Ͽ� �����ϸ� �����ڴ� ���� ������ �� �� ����)
// (false �϶����� ORDERBYLEV �÷��� ����ϸ� �����ڴ� ���� ������ ������)
//boolean g_bDeptRank = false;

//��õ��û �䱸����
//���۰����ڿ� ��ü �ּҷ� ���� ��ȸ : ������� ����� �߿��� �ߺ� ����(2014.12.22 ������)
//admin �������� �α��� => �ý��۰��� => �����ּҷϰ���
boolean g_addressTotalCountFlag = false;

//���� �ּҷ� ���� �ٿ�ε� ��ư Ȱ��ȭ ���� (2014.12.30 ������)
//admin �������� �α��� => �ý��۰��� => �����ּҷϰ���
boolean g_empAddressExcelDownFlag = false;

//������ ����ϰ� �ִ� SMS ���񽺸� �˾����� ����ִ� ��ư ǥ�ÿ���(2015.02.27 ������)
boolean dispOtherSmsService = false;

//���� SMS �������� admin �������� ǥ������ ��ü ����ڿ��� ǥ������ ����(2015.07.14 ������)
//dispOtherSmsService = true �� ��� dispOtherSmsServiceAdmin = true �̸� admin ������ ���̱�.
//dispOtherSmsServiceAdmin = false �̸� ��ü ����ڿ��� ���̱�.
boolean dispOtherSmsServiceAdmin = false;

//������ ����ϰ� �ִ� SMS ���� URL(2015.02.27 ������)
//dispOtherSmsService =  true �� ��� ��� ��
String otherSmsServiceUrl = "http://www.naver.com";

//���۰��� => ������ȸ ȭ������ �̵� �� ���ʷ� �����ִ� ȭ�� ����(2015.04.16 ������)
// �߼۴��� : J, �޽��� ���� : M
String sendListScreenFlag = "J";

//���۰��� => ������ȸ ȭ������ �̵� �� ���ʷ� �����ִ� ȭ�� JSP ���ϸ�(2015.04.16 ������)
String sendListScreen = "sendJobList.jsp";
if( "M".equals( sendListScreenFlag ) ) sendListScreen = "sendMessageList.jsp";

//�޽��� ������ "������ ����" �׸� �ʼ� �Է� ����(2015.04.17 ������)
// Y : �ʼ��Է�, N : �ʼ��ƴ� (Select Box�� Option�� "����" ����)
// NA : �ʼ��ƴ�. "-�������ּ���-"�� �⺻. �׷��� "-�������ּ���-" ���·� ���۽� ���â �߰� ���۾ȵ�  (2016.11.14 �����)
// ND : �ʼ��ƴ�. ȭ�鿡 ���������� ǥ�õ� �ȵ�. (2017.05.11 KKW)
String workSeqRequiredFlag = "NA";

//�� �޼��� ���� ȭ�鿡�� �޼��� ���뿡 ��� ������ �������� ����(2015.04.20 ������)
//boolean messageLayerFlag = true;

//push ��� ��뿩�� 2015.07.06 ������(igov.properties ���� ����)
String pushUseFlag = PropertiesManager.getProperties("pushUseFlag");

//������ ��� ��뿩�� 2015.07.06 ������(igov.properties ���� ����)
//String familyEventUseFlag = PropertiesManager.getProperties("familyEventUseFlag");

//���� �߼� �� �߽Ź�ȣ ���� ���� ���� ��Ģ ���� ����(true: ��Ģ ����, false: ��Ģ ������)
boolean fakeNumberPreventUseFlag = true;

//�α��� �� �߽Ź�ȣ ���� ���� ���� �ȳ� �˾�â�� ���� ��� ��� ����(true: �˾�â ����, false: �˾�â �ȶ���)
boolean fakeNumberPreventPopUpUseFlag = false;

//ĳ�������ʹ� tbuser ���̺��� nlevel=2


// �μ��ּҷ� ��� ���ۿ� ���� ���� (igov.properties ���� ����) (2016.05.04 KKW)
// - �ּҷ� ���� ��å
// 	g_DeptShareGubun <--------- ""
// 		�μ��ּҷ� : �ٸ� ����ڰ� �μ������� �ּҷ��� �����ڰ� ǥ�þȵǸ� �ּҷ� �̸��� ����.
// 		�μ��ּҷ� : �ٸ� ����ڰ� ����� ��ȭ��ȣ�� ������ �����ϳ� ������ ����.
// 		�ּҷ� : �ּҷ� �����ڴ� �ٸ� ����ڿ��� ���ӵ� �ּҷϰ���(�ּҷ� ��������,�׷�����,�׷����)�� ����.
// 		�ּҷ� : ���������(���ӹ�����)�� �ּҷ� ��������, �׷�����, �׷���� ������.
// 		�ּҷ� : ���������(���ӹ�����)�� �ٸ� ����ڰ� ����� ��ȭ��ȣ ������ �����ϳ� ������ ����.
// - �ּҷ� V2��å (2016.05.04)
// 	g_DeptShareGubun <---------- "V2"
// 		�μ��ּҷ� : �ٸ� ����ڰ� �μ������� �ּҷ��� �����ڰ� �ּҷ� �̸����� �߰� ǥ�õ�.
// 		�μ��ּҷ� : �ٸ� ����ڰ� ����� ��ȭ��ȣ�� ����, ���� ������. (��, �μ����� �ּҷ��� �����ڰ� �ƴ϶�� �׷����,�׷���� ����)
// 		�ּҷ� : ���������(���ӹ�����)�� �ּҷ� �̸����� �μ������� ���� �����ڰ� �߰� ǥ�õ�.
// 		�ּҷ� : �ּҷ� �����ڴ� �ٸ� ����ڿ��� ���ӵ� �ּҷϰ���(�ּҷ��� ��������,�׷�����,�׷����)�� ��ȭ��ȣ ������ ������.
// 		�ּҷ� : �ּҷ� �����ڴ� �ٸ� ����ڰ� ����� ��ȭ��ȣ�� ����, ���� ������.
// 		�ּҷ� : ���������(���ӹ�����)�� ��ȭ��ȣ�߰�,����,������ ���� ���Ѹ� ����. (�ּҷ��� ��������, �׷�����, �׷������ �Ұ�����)
// 		�ּҷ� : ���������(���ӹ�����)�� �ٸ� ����ڰ� ����� ��ȭ��ȣ�� ����, ���� ������.
//String g_DeptShareGubun = PropertiesManager.getProperties("g_DeptShareGubun");

// �μ��� �μ��ּҷϰ��� �޴� ǥ�� ���� �ɼ� (true:ǥ��, false:��ǥ��) (20160526 KKW)
//  g_bDeptAddressMenuDisplay=true, departActive=true : �޴� ǥ��.
//  g_bDeptAddressMenuDisplay=false, departActive=true : �޴� ��ǥ��.
//  g_bDeptAddressMenuDisplay=true, departActive=false : �޴� ��ǥ��.
boolean g_bDeptAddressMenuDisplay = true;

// �̸�Ƽ�� ��ư ǥ�� ���� �ɼ� (true:ǥ��, false:��ǥ��) (2016.11.14 KKW)
boolean g_emoticonDisplay = false;

// �α��� ȸ������ Ȱ��ȭ �� ����������޹�ħ ǥ�� �ɼ� (true:����������޹�ħǥ��, false:����������޵��Ǿ��̰���ȭ��) (2017.02.23 KKW)
//  dispMemberJoin = true �϶��� ȿ���� ����. dispMemberJoin �� false �̸� �� �ɼ��� ���õ�.
boolean g_dispMemberJoin_privacy = false;

// �α��� ȸ�����Խ��� �޴� Ȱ��ȭ �ɼ�
//  dispMemberJoin = true �϶��� Ȱ��ȭ �ɼ��� ���۵�. dispMemberJoin �� false �̸� �� �ɼ��� ���õ�.
boolean g_dispMemberApprovalMenu = true;

//--------------- ĳ�� ���� ��ü --------------- ���� (2017.04.05 KKW)
//  ##### ����1 : igov.properties ������ g_dispCashImage ������ �����ϸ� ��.
//  ##### ����2 : �� ������ �Ʒ� ������ �״�� ����ؾ� �ϸ� ��ü �����̳� ���� �������� ����.
//String g_dispCashImage = PropertiesManager.getProperties("g_dispCashImage");
//String g_dispCashText = "ĳ��";
//String g_dispCashText2 = "�ݾ�";
//String g_dispCashText2_2 = g_dispCashText2 + "��";
//String g_dispCashText3 = "���";
//String g_dispCashText3_2 = g_dispCashText3 + "��";
//String g_dispCashText4 = "��";
//if (g_dispCashImage != null && g_dispCashImage.equals("_num")) g_dispCashText = "�Ǽ�";
//if (g_dispCashImage != null && g_dispCashImage.equals("_num")) g_dispCashText2 = g_dispCashText;
//if (g_dispCashImage != null && g_dispCashImage.equals("_num")) g_dispCashText2_2 = g_dispCashText2 + "��";
//if (g_dispCashImage != null && g_dispCashImage.equals("_num")) g_dispCashText3 = g_dispCashText;
//if (g_dispCashImage != null && g_dispCashImage.equals("_num")) g_dispCashText3_2 = g_dispCashText3 + "��";
//if (g_dispCashImage != null && g_dispCashImage.equals("_num")) g_dispCashText4 = "��";
//--------------- ĳ�� ���� ��ü --------------- �� (2017.04.05 KKW)

// ��ް��� �޴��� ���� ��� Ȱ��ȭ �ɼ� (true:Ȱ��ȭ, false:��Ȱ��ȭ) (2017.04.26 KKW)
//  ##### ���� : ���� �ɼ� �� g_UserCashLimitCheckFlag = "C" , g_addcashLimitCheckFlag = false �� ���� �ʿ�.
//  Ȱ��ȭ �� ����ں� ����� �����Ͽ� ĳ��(�Ǽ�)�� �����ϰԵ�. ���� �ɼ� ���� ����.
//  Ȱ��ȭ �� ��� TBLEVELCODE ���̺� ���� �ʼ�
//   CREATE TABLE TBLEVELCODE (LEVELCASH NUMBER(11,3) NOT NULL, LEVELNAME VARCHAR2(40) NOT NULL, DISPORDER NUMBER(3,0) DEFAULT 0, REGDATE DATE);
//   CREATE UNIQUE INDEX IDX_TBLEVELCODE_01 ON TBLEVELCODE(LEVELCASH);
//boolean g_levelCodeUseFlag = false;

// ���ڹ߼� �� �ٷ����� ���� �޽����� ������ ������ �� ���â ��� �߼�Ȯ�� Ȱ��ȭ �ɼ� (true:Ȱ��ȭ, false:��Ȱ��ȭ) (2017.05.10 KKW)
//boolean g_dupMessageUseFlag = false;

// ���������� �������۱��� �̹��� ��ũ ���� ("":��ũ���� , "/manual/sample.hwp":�ش����ش����ϸ�ũ)
//   * �� �ɼ��� g_yeongdongImgDisplay �ɼ��� true �϶����� ȿ�� �߻���.
//   * hwp �ٿ�ȵɶ� : tomcat cont/web.xml ���Ͽ� �Ʒ� ���� �߰� �� �����. ����ں����� ĳ�û���.
//			<mime-mapping>
//				<extension>hwp</extension>
//				<mime-type>application/unknown</mime-type>
//			</mime-mapping>
String g_yeongdongImgDisplayFileLink = "/manual/siheung.hwp";

// ����� ȭ���� ĳ��(�Ǽ�)�� ����߼�ĳ��(�Ǽ�) ǥ�� ���� �ɼ� (true:ǥ��, false:��ǥ��) (2017.07.10 KKW)
//   (���� dispPossibleSendCnt = false; , g_dispCashTextUseFlag = false;)
//   ��, �μ����� ������ �μ�ĳ��(�Ǽ�) �Ǽ��� ǥ�õ�
//   ���� : ���� �����߼۰��� �Ǽ� ǥ�� �ɼ��� dispPossibleSendCnt �ɼ��� ��� �ٶ�
//boolean g_dispCashTextUseFlag = false;

// �����߼۰��� �Ǽ� ǥ�� ���� ���� (����:TYPE_OR , �׿�:NORMAL) (2017.07.10 KKW)
//   g_dispPossibleSendCntFormat = "NORMAL";  �ܹ� ->10�� 
//   									�幮 ->8�� 
//   									��Ƽ ->6�� 
//   g_dispPossibleSendCntFormat = "TYPE_OR";  �ܹ� 10�� �Ǵ� 
//   									�幮 8�� �Ǵ� 
//   									��Ƽ 6�� �߼� ����
String g_dispPossibleSendCntFormat = "TYPE_OR";

// �������� ��� ���� (true:��� , false:������) (2017.07.11 KKW)
boolean g_noticeUseFlag = false;

// �������� ÷������ ���� ���丮 (igov.properties ���� NOTICEFILEPATH ����) (2017.07.11 KKW)
//   (���⼭ ���� �������� ����)
String g_noticeFilePath = PropertiesManager.getProperties("NOTICEFILEPATH");

// �ѱ۾��̵� ��� ���� (true:��� , false:������) (2017.07.18 KKW)
//boolean g_hangulidFlag = false;

//���۰����� ž����޴� �޴��� ���м� ���� ���� (2017.07.25 KKW)
String g_admin_subMenuBarHeight = "255";

// �������� �������� ���� �� �⺻ ���̸� ����(2017.10.13 KKW)
//   �⺻������ ���� (��������) : g_replyDataLength = "10";
//   ���ؽ�û : g_replyDataLength = "20";
String g_replyDataLength = "20";

// ����ȭ�� �ּҷ� ���ļ��� ����  (igov.properties ����  g_AddressGroupOrderBy ����) (2017.12.21 KKW)
//   (���⼭ ���� �������� ����)
// õ�Ƚ�û (�ּҷϸ� ��������) : g_AddressGroupOrderBy=TITLE
//							-- (�׷챸�� grpflag ���� g_DeptShareGubun �ɼ� ������ ���� ������ �ּҷϸ� �����������θ� ����)
// �׿� (�ٸ� �ɼǿ� ���� ����) : g_AddressGroupOrderBy=
//							-- (�׷챸�� grpflag ���� g_DeptShareGubun �ɼ� ���⿡ ���� ����)
//String g_AddressGroupOrderBy = PropertiesManager.getProperties("g_AddressGroupOrderBy");

// ������ ������� IP Ȱ��ȭ ���� (2017.12.28 KKW)
//   (���⼭ ���� �������� ����)
// g_admin_checkIp=Y : ������ ������� IP Ȱ��ȭ (����û)
// g_admin_checkIp=N : ������ ������� IP ��Ȱ��ȭ (����û �̿�)
//String g_admin_checkIp = PropertiesManager.getProperties("g_admin_checkIp");

// �ܹ�, �幮, ��Ƽ �ִ� byte ���� (2018.02.05 KKW)
//   (���⼭ ���� �������� ����)
// g_MaxByte_smsurl=80 (default: 80 , õ�Ƚ�û: 90)
// g_MaxByte_lmsmms=1500 (default: 1500 , õ�Ƚ�û: 1800)
//String g_MaxByte_smsurl = PropertiesManager.getProperties("g_MaxByte_smsurl");
//String g_MaxByte_lmsmms = PropertiesManager.getProperties("g_MaxByte_lmsmms");

// ���� �ּҷ� �� ǥ�� ���� (�ϵ���û false, ������ true) (2018.08.06 KKW)
//* ������� : �ּҷ� �������� �����ּҷ� ��ɰ� ���� ���� ��� ���δ� ���� �ɼ� �� �Ʒ� ������ �����Ͽ� �����Ұ�
//  1) ����� - igov.properties ���� : MEMADDRCOPYFLAG=N , MEMADDREXCELEXPORT=N
//  2) ������ - config.jsp ���� : g_empAddressExcelDownFlag = false
// g_empAddressTabDisplayFlag = false (��ǥ��)
// g_empAddressTabDisplayFlag = true (ǥ��)
//boolean g_empAddressTabDisplayFlag = true;

// ������-����ڰ��� ����Ʈ�� �������� �˻� ǥ�� ���� (2018.08.20 KKW)
//   (���⼭ ���� �������� ����)
// g_UserList_WorkState=Y : ������ ����ڰ��� ����Ʈ�� �������� �˻� ǥ�� (ȭõ��û)
// g_UserList_WorkState=N : ������ ����ڰ��� ����Ʈ�� �������� �˻� ǥ�þ���
String g_UserList_WorkState = PropertiesManager.getProperties("g_UserList_WorkState");

// ������-ȸ�����Խ��� ����Ʈ�� ���� ��� ǥ�� ���� (2018.08.21 KKW)
//    + ȸ������Ʈ ��ȭ�鿡�� ��뿩�ΰ� "���", "�̻��" �� --> "���δ��" �� ���� �� ���� �Ұ��� (2018.11.15 KKW)
// ������� : �켱 g_dispMemberApprovalMenu = true �̾�� ��
// g_UserApproval_Delete = true (������ư ǥ��) (ȭõ��û)
// g_UserApproval_Delete = false (������ư ��ǥ��)
//boolean g_UserApproval_Delete = true;

//������-ȸ�� ��Ͽ� "���δ��" ȸ�� ���� ���� (2018.11.15 KKW)
//(���⼭ ���� �������� ����)
//** ���� : ȭõ��û�� config.jsp ���� g_UserApproval_Delete = true �����ϰ�, igov.properties ���� g_UserList_Except_Approval=Y �� �����Ұ�.
//g_UserList_Except_Approval=Y : ������ ����ڰ��� ����Ʈ�� "���δ��" ȸ�� ǥ�� ���� (ȭõ��û)
//g_UserList_Except_Approval=N : ������ ����ڰ��� ����Ʈ�� "���δ��" ȸ�� ǥ�� ���ܾ���. ���� ���� ������ ����.
//String g_UserList_Except_Approval = PropertiesManager.getProperties("g_UserList_Except_Approval");

// ���������� ���� �������� ��� ���� (2018.11.30 KKW)
//   �ٸ� �ɼ� �� messageLayerFlag = true �϶����� ���� ������ ��
// g_messageLayerVersion = "V1";  (���� ���� ����â�� ��� ���)
// g_messageLayerVersion = "V2";  (��ü ȭ���� ���� ��� ���)
String g_messageLayerVersion = "V2";

// ���������� ���� �������� ��� ��� html (2018.11.30 KKW)
//   �ٸ� �ɼ� �� messageLayerFlag = true �϶����� ���� ������ ��
//   �ٸ� �ɼ� �� g_messageLayerVersion = "V2" �϶����� ���� ������ �� (V1�� common.js ���� html ���� �ʿ�)
// ------------------
//   �⺻ ����
//    String g_messageLayerHtml = "<font color='red'>1. ���������� �������� ����</font>"
//		+ "<br/>&nbsp;&nbsp;&nbsp;&nbsp;(������ �ൿ���� ��13��)"
//		+ "<br/>"
//		+ "<br/><font color='red'>2. ��������(�ֹε�Ϲ�ȣ)</font>"
//		+ "<br/>&nbsp;&nbsp;&nbsp;&nbsp;���� �Ұ�"
//		+ "<br/><br/><br/>";
//   �����û ����
//    String g_messageLayerHtml = "<font color='red'>�������� �� ���� ����</font>"
//		+ "<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(����� ������ �ൿ���� ��14��)"
//		+ "<br/><br/>- �������� �뵵�� ����� �� �������� �߻��� �� ����"
//		+ "<br/><br/>- ������Ű����� ���� ���� ���� ����͸� �ǽ�"
//		+ "<br/><br/><br/>";
String g_messageLayerHtml = "<font color='red'>1. ���������� �������� ����</font>"
		+ "<br/>&nbsp;&nbsp;&nbsp;&nbsp;(������ �ൿ���� ��13��)"
		+ "<br/>"
		+ "<br/><font color='red'>2. ��������(�ֹε�Ϲ�ȣ)</font>"
		+ "<br/>&nbsp;&nbsp;&nbsp;&nbsp;���� �Ұ�"
		+ "<br/><br/><br/>";

// MO ��� ��� ����(2019.03.05 cjm)
//   (���⼭ ���� �������� ����)
// Y:���, N:�̻��
//String g_MO_USE = PropertiesManager.getProperties("g_MO_USE");

// �μ��� ��� ��� ���� �ɼ� (2019.03.29 KKW)
// g_DeptHeadFunctionYN = "N" : �μ���� �Ϲ� ����� ������ ����
// g_DeptHeadFunctionYN = "Y" : �μ���α��� �� ���� �޴��� �μ��� �޴� ǥ��. ����� �������� �μ��� ���� ���� (��: ��õ��û)
// ** ���� : Y�� ���� �� ���� �μ��� �ɼ� �� �����Ǿ� ���۵Ǵ� �ɼ��� ���� �� ����
//   (���⼭ ���� �������� ����)
//String g_DeptHeadFunctionYN =  PropertiesManager.getProperties("g_DeptHeadFunctionYN");

// ���� ���� ��� ��� ���� �ɼ� (2019.03.29 KKW)
// g_SendIntegrationFunctionYN = "N" : ����ȭ���� ����޴��� ���� �����Ǵ� ���� ���۱��
// g_SendIntegrationFunctionYN = "Y" : ����ȭ���� tab���� ���е� renewal ���� ȭ�� (��: ��õ��û)
String g_SendIntegrationFunctionYN = "Y";

// �߽Ź�ȣ ��� ���� (2019.05.09 KKW)
// g_CallbackInputType = "" : ���� ������ ���� 5.0 �����Է� ���
// g_CallbackInputType = "CAUTH" : ���� CAUTH �̸� �μ��� �߽Ź�ȣ�� �̹� ��ϵ� ��ȣ�� ���ð���. ����� �����Ͽ� ���� ���� �ʿ���.
//String g_CallbackInputType = "";
//String g_CallbackInputType = "CAUTH";

//�޽��� ������ "������ ����" �Ǵ� "��������" �׸񿡼� "�̺з�"(value = 0)�� �������� ���̰� ���� �Ⱥ��̰� ���� (2019.05.15 cjm)
//���ȭ�鿡���� DB�� ��ϵ� ���� �״�� �����ֱ� ������ �ش� �ɼǿ� ������ ���� �ʴ´�.
// Y : �̺з� ���(Select Box�� �̺з� ���ð��� ǥ��)
// N : �̺з� �̻��(Select Box�� �̺з� ���ð��� ǥ�õ��� ����)
String g_workSeqZeroCodeUseYN = "Y";

//ģ���忡�� �̹��� ��뿩�� (2019.05.20 cjm)
// true : �̹��� ���
// false : �̹��� �̻��
//boolean g_FriendTalkImageUseFlag = true;

// ���������� �������۱��� �˸�â�� �󸶳� ���� ǥ������ �����ϴ� �ɼ� (2019.06.17 KKW)
// �ٸ� �ɼ� �� messageLayerFlag = true �϶����� ȿ���� �ֽ�
// ��) String g_messageLayerCycle = "LOGIN"; // �Ǻ� �α��δ� �ѹ��� ��� (��õ��û �����)
// ��) String g_messageLayerCycle = ""; // �׻� ǥ��
//String g_messageLayerCycle = "LOGIN";

// ���������� �������۱��� ��� ***ģ����*** ȭ�� ���� �߰� html (2019.06.17 KKW)
//   �ٸ� �ɼ� �� messageLayerFlag = true �϶����� ���� ������ ��
//   �ٸ� �ɼ� �� g_messageLayerVersion = "V2" �϶����� ���� ������ �� (V1�� common.js ���� html ���� �ʿ�)
// ------------------
//   �⺻ ����
//    String g_messageLayerFrdAddHtml = "";
//   ��õ��û ����
//    String g_messageLayerFrdAddHtml = "<font color='red'>* ģ���� �߼� ����ð� : 20�� ~ ���� 08��</font>"
//		+ "<br/>&nbsp;&nbsp;&nbsp;&nbsp;����ð����� �߼��� ���еǹǷ�, �ð��� Ȯ��"
//		+ "&nbsp;&nbsp;&nbsp;&nbsp;�Ͻñ� �ٶ��ϴ�."
//		+ "<br/><br/><br/>";
String g_messageLayerFrdAddHtml = "";

// MMS image �� �߼۰��� �ɼ� - MMS �ؽ�Ʈ ������� �߼� ������ �ɼ� (2019.06.19 KKW)
// g_mms_imageonly_send=N : MMS image�� �߼� �Ұ���
// g_mms_imageonly_send=Y : MMS image�� �߼� ���� (��: ��õ��û)
// ** ���� : (���⼭ ���� �������� ����)
//String g_mms_imageonly_send =  PropertiesManager.getProperties("g_mms_imageonly_send");

// ����� �˸������ø� ���� �޴� ǥ�� �ɼ� (2019.06.25 KKW)
// boolean g_user_alimtalk_template_manage_menu = true; : �޴� ǥ��
// boolean g_user_alimtalk_template_manage_menu = false; : �޴� ���߱� (��õ��û �����)
//boolean g_user_alimtalk_template_manage_menu = true;

// �μ��� �μ������ ���� �޴� ǥ�� �ɼ� (2019.06.25 KKW)
// �ٸ� �ɼ� �� g_DeptHeadFunctionYN = Y �϶����� ȿ���� �ֽ�
// boolean g_master_user_regist_menu = true; : �޴� ǥ��
// boolean g_master_user_regist_menu = false; : �޴� ���߱� (��õ��û �����)
//boolean g_master_user_regist_menu = true;

// �������� �� ���� ���θ޴��� Ŭ�������� �̵��ϴ� URL (2019.06.26 KKW)
// String g_integration_send_menu_click_url = "/message/sendALTIntegration.jsp";
// String g_integration_send_menu_click_url = "/message/sendFRTIntegration.jsp";
// String g_integration_send_menu_click_url = "/message/sendSMSIntegration.jsp";
// String g_integration_send_menu_click_url = "/message/sendMMSIntegration.jsp";
String g_integration_send_menu_click_url = "/message/sendALTIntegration.jsp";

// ���۰��� > ������ȸ > �˻���¥ �ִ�Ⱓ ������ ����(2019.10.21 cjm)
// �˻���¥�� ���� �� �������� ��� �� �������� ��ȸ �����ϰ� �Ұ��� ����.
// 0 = ��� ������.(������� ���� ����)
// n = n���� ~ ����� (���ڸ� �Է�. ����� - n)
int g_messageListSearchMonthLimit = 0;

// ���۰��� > ������ȸ > �˻���¥ �ּұⰣ ������ ����(2019.10.25 cjm)
// �˻���¥�� ���� �� �������� ��� �� �������� ��ȸ �����ϰ� �Ұ��� ����.
// 0 = ���� ������ ��ȸ ���� (���� ������ �������� ���� ������ �ʾ� ���Ұ�)
// n = n���� ~ ���� ���� (���ڸ� �Է�. ����� - n)
int g_messageListSearchYearLimit = 5;
%>
