// MIT License
//
// Copyright (c) 2020 Olivier Le Doeuff
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#include <Qaterial/IO/FolderTreeModel.hpp>

#include <QtCore/QDir>
#include <QtCore/QFileInfo>
#include <QtCore/QLoggingCategory>

Q_LOGGING_CATEGORY(qaterialFTM, "qaterial.folderTreeModel")

namespace qaterial {

FolderTreeModel::FolderTreeModel(QObject* parent)
    : qolm::QOlm<FolderTreeModel>(parent)
{
    // Default the url to the application location if one is found
    _path.setPath(QDir::currentPath());
    const auto fileInfo = QFileInfo(QDir::currentPath());

    _fileName = fileInfo.fileName();
    _filePath = fileInfo.absoluteFilePath();
    _fileBaseName = fileInfo.baseName();
    _fileCompleteBaseName = fileInfo.completeBaseName();
    _fileSuffix = fileInfo.suffix();
    _fileCompleteSuffix = fileInfo.completeSuffix();
    _fileSize = fileInfo.size();
    _fileModified = fileInfo.lastModified();
    _fileAccessed = fileInfo.lastRead();
    _fileIsDir = fileInfo.isDir();

    initializeBindings();
}

FolderTreeModel::FolderTreeModel(const QUrl& path,
    const QString& fileName,
    const QString& filePath,
    const QString& fileBaseName,
    const QString& fileCompleteBaseName,
    const QString& fileSuffix,
    const QString& fileCompleteSuffix,
    qint64 fileSize,
    const QDateTime& fileModified,
    const QDateTime& fileAccessed,
    bool fileIsDir,
    QObject* parent)
    : QOlm<FolderTreeModel>(parent)
    , _path(path)
    , _fileName(fileName)
    , _filePath(filePath)
    , _fileBaseName(fileBaseName)
    , _fileCompleteBaseName(fileCompleteBaseName)
    , _fileSuffix(fileSuffix)
    , _fileCompleteSuffix(fileCompleteSuffix)
    , _fileSize(fileSize)
    , _fileModified(fileModified)
    , _fileAccessed(fileAccessed)
    , _fileIsDir(fileIsDir)
{
    initializeBindings();
}

void FolderTreeModel::initializeBindings()
{
    // Bind dot dot dot dot dot dot
    connect(this,
        &FolderTreeModel::showDotChanged,
        [this]()
        {
            if(_dotEvaluation)
                return;
            _dotEvaluation = true;
            setShowDotAndDotDot(showDotDot() && showDot());
            _dotEvaluation = false;
        });

    connect(this,
        &FolderTreeModel::showDotDotChanged,
        [this]()
        {
            if(_dotEvaluation)
                return;
            _dotEvaluation = true;
            setShowDotAndDotDot(showDotDot() && showDot());
            _dotEvaluation = false;
        });

    connect(this,
        &FolderTreeModel::showDotAndDotDotChanged,
        [this]()
        {
            if(_dotEvaluation)
                return;
            _dotEvaluation = true;
            setShowDot(showDotAndDotDot());
            setShowDotDot(showDotAndDotDot());
            _dotEvaluation = false;
        });

    // Spread filter configuration
    onInserted(this,
        [this](FolderTreeModel* folder)
        {
            folder->setCaseSensitive(caseSensitive());
            folder->setNameFilters(nameFilters());
            folder->setShowDrives(showDrives());
            folder->setShowDirs(showDirs());
            folder->setShowDirsFirst(showDirsFirst());
            folder->setShowDotAndDotDot(showDotAndDotDot());
            folder->setShowFiles(showFiles());
            folder->setShowHidden(showHidden());
            folder->setShowOnlyReadable(showOnlyReadable());
            folder->setSortCaseSensitive(sortCaseSensitive());
            folder->setSortField(sortField());
            folder->setSortReversed(sortReversed());
        });
}

FolderTreeModel* FolderTreeModel::children()
{
    return this;
}

QUrl FolderTreeModel::path() const
{
    return _path;
}

bool FolderTreeModel::setPath(const QUrl& value)
{
    if(value != _path)
    {
        _path = value;
        auto pathString = _path.path();
        if(pathString.isEmpty())
            pathString = QDir::currentPath();
        const auto fileInfo = QFileInfo(pathString);

        setFileName(fileInfo.fileName());
        setFilePath(fileInfo.absoluteFilePath());
        setFileBaseName(fileInfo.baseName());
        setFileCompleteBaseName(fileInfo.completeBaseName());
        setFileSuffix(fileInfo.suffix());
        setFileCompleteSuffix(fileInfo.completeSuffix());
        setFileSize(fileInfo.size());
        setFileModified(fileInfo.lastModified());
        setFileAccessed(fileInfo.lastRead());
        setFileIsDir(fileInfo.isDir());

        Q_EMIT pathChanged(value);
        return true;
    }
    return false;
}

void FolderTreeModel::resetPath()
{
    setPath({});
}

void FolderTreeModel::fetch()
{
    if(!fileIsDir())
    {
        qCWarning(qaterialFTM) << "Can't fetch folders of a file {}." << path().path();
        return;
    }

    // todo : provide a smarter implementation that reuse already instantiated folders
    clear();

    const auto currentDirectory = QDir(path().path());

    QDir::Filters filters;
    if(caseSensitive())
        filters.setFlag(QDir::CaseSensitive);
    if(showDirs())
        filters.setFlag(QDir::Dirs);
    if(showHidden())
        filters.setFlag(QDir::Hidden);
    if(showOnlyReadable())
        filters.setFlag(QDir::Readable);
    if(!showDot())
        filters.setFlag(QDir::NoDot);
    if(!showDotDot())
        filters.setFlag(QDir::NoDotDot);
    const auto folderFilter = filters;
    if(showFiles())
        filters.setFlag(QDir::Files);

    QDir::SortFlags sortFlags;
    if(showDirsFirst())
        sortFlags.setFlag(QDir::DirsFirst);
    if(sortReversed())
        sortFlags.setFlag(QDir::Reversed);
    if(!sortCaseSensitive())
        sortFlags.setFlag(QDir::IgnoreCase);
    switch(SortField(sortField()))
    {
    case Name:
        sortFlags.setFlag(QDir::Name);
        break;
    case Time:
        sortFlags.setFlag(QDir::Time);
        break;
    case Size:
        sortFlags.setFlag(QDir::Size);
        break;
    case Type:
        sortFlags.setFlag(QDir::Type);
        break;
    default:;
    }

    const auto appendFolder = [&](QFileInfoList& list) { list += currentDirectory.entryInfoList(folderFilter, sortFlags); };
    const auto secondFetchForFolderIsRequired = !nameFilters().empty() && showDirs();

    // Fetch all entries and append in one operation
    QFileInfoList fileInfoList;
    if(secondFetchForFolderIsRequired && showDirsFirst())
        appendFolder(fileInfoList);

    fileInfoList += currentDirectory.entryInfoList(nameFilters(), filters, sortFlags);

    if(secondFetchForFolderIsRequired && !showDirsFirst())
        appendFolder(fileInfoList);

    QList<FolderTreeModel*> folders;

    for(const auto& fileInfo: fileInfoList)
    {
        folders.append(new FolderTreeModel(path().path() + '/' + fileInfo.fileName(),
            fileInfo.fileName(),
            fileInfo.absoluteFilePath(),
            fileInfo.baseName(),
            fileInfo.completeBaseName(),
            fileInfo.suffix(),
            fileInfo.completeSuffix(),
            fileInfo.size(),
            fileInfo.lastModified(),
            fileInfo.lastRead(),
            fileInfo.isDir(),
            this));
    }

    if(!folders.empty())
        append(folders);
}

}
