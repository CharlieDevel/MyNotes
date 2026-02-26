import win32com.client
import pythoncom
import time

FORWARD_FROM_ACCOUNT = "charliedevel@hotmail.com"
FORWARD_TO_EMAIL = "carlos@keostech.com"

last_entry_id = None

def get_outlook_session():
    outlook = win32com.client.Dispatch("Outlook.Application")
    return outlook, outlook.GetNamespace("MAPI")

def get_forwarding_account(session):
    for account in session.Accounts:
        if account.SmtpAddress.lower() == FORWARD_FROM_ACCOUNT.lower():
            return account
    return None

def forward_message(mail, forwarding_account):
    forward = mail.Forward()
    forward.Recipients.Add(FORWARD_TO_EMAIL)
    forward.Subject = "[-carlblan-] " + mail.Subject
    forward.SendUsingAccount = forwarding_account
    forward.Send()
    print(f"✅ Forwarded: {mail.Subject}")

def send_subject_only(mail, outlook, forwarding_account):
    new_mail = outlook.CreateItem(0)  # 0 = olMailItem
    new_mail.To = FORWARD_TO_EMAIL
    new_mail.Subject = "[-carlblan-] " +  mail.Subject
    new_mail.Body = ""  # No body content
    new_mail.SendUsingAccount = forwarding_account
    new_mail.Send()
    print(f"✅ Sent subject only: {mail.Subject}")
    
while True:
    try:
        pythoncom.CoInitialize()

        outlook, session = get_outlook_session()
        forwarding_account = get_forwarding_account(session)
        if not forwarding_account:
            print(f"❌ Could not find account: {FORWARD_FROM_ACCOUNT}")
            break

        inbox = session.GetDefaultFolder(6)  # olFolderInbox
        messages = inbox.Items
        messages.Sort("[ReceivedTime]", True)
        newest = messages.GetFirst()

        if newest and newest.Class == 43:  # 43 = MailItem
            if newest.EntryID != last_entry_id:
                send_subject_only(newest, outlook, forwarding_account)
                # forward_message(newest, forwarding_account)
                last_entry_id = newest.EntryID

        pythoncom.CoUninitialize()
        time.sleep(10)

    except Exception as e:
        print(f"❌ Error: {e}")
        time.sleep(30)
